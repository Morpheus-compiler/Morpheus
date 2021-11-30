--- Software timestamping precision test.
--- (Used for an evaluation for a paper)
local mg     = require "moongen"
local ts     = require "timestamping"
local device = require "device"
local hist   = require "histogram"
local memory = require "memory"
local stats  = require "stats"
local timer  = require "timer"
local ffi    = require "ffi"
local limiter = require "software-ratecontrol"
local log    = require "log"
local pcap   = require "pcap"

local PKT_SIZE = 60

local NUM_PKTS = 10^6

-- set addresses here
local SRC_MAC       = "<PKTGEN_MAC_IF1>"
local DST_MAC		= "<PKTGEN_MAC_IF2>"
local SRC_IP	    = "140.138.0.1"
local DST_IP		= "10.70.1.2"
local SRC_PORT		= 1234
local DST_PORT		= 319

local OUTER_SRC  	= "172.16.210.5"

local TS_SRC_MAC    = "<PKTGEN_MAC_IF1>"
local TS_DST_MAC	= "<PKTGEN_MAC_IF2>"
local TS_SRC_IP	    = "180.20.1.1"
local TS_DST_IP		= "10.70.1.5"
local TS_SRC_PORT	= 319
local TS_DST_PORT	= 319

local uint64Ptr = ffi.typeof("uint64_t*")

function master(txPort, rxPort, load, tsLoad, time)
	if not txPort or not rxPort or type(load) ~= "number" or type(time) ~= "number" or type(tsLoad) ~= "number" then
		errorf("usage: txPort rxPort load tsLoad timelimit (sec)")
	end

	local txDev = nil
	local rxDev = nil

    local rxQueue = 1
    if (load > 0) then 
        rxQueue = 2 
    end
	if txPort == rxPort then
		txDev = device.config{port = txPort, rxQueues = rxQueue, txQueues = 2}
		rxDev = txDev
	else
		txDev = device.config{port = txPort, rxQueues = 1, txQueues = 2}
		rxDev = device.config{port = rxPort, rxQueues = rxQueue}
	end
	device.waitForLinks()

	if load > 0 then
		txDev:getTxQueue(1):setRate(load * (PKT_SIZE + 4) * 8)
		mg.startTask("loadSlave", txDev:getTxQueue(1), rxDev:getRxQueue(1), queueLimiter)
	end

	mg.startTask("txTimestamper", txDev:getTxQueue(0), time, tonumber(tsLoad))
	mg.startTask("rxTimestamper", rxDev:getRxQueue(0))
	mg.waitForTasks()
end

local function fillTsUdpPacket(buf)
	buf:getUdpPacket():fill{
		ethSrc = TS_SRC_MAC,
		ethDst = TS_DST_MAC,
		ip4Src = TS_SRC_IP,
		ip4Dst = TS_DST_IP,
		udpSrc = TS_SRC_PORT,
		udpDst = TS_DST_PORT,
		pktLength = PKT_SIZE
	}
end

local function fillUdpPacket(buf)
	buf:getUdpPacket():fill{
		ethSrc = SRC_MAC,
		ethDst = DST_MAC,
		ip4Src = SRC_IP,
		ip4Dst = DST_IP,
		udpSrc = SRC_PORT,
		udpDst = DST_PORT,
		pktLength = PKT_SIZE
	}
end

function getDelay(rate)
	local cbr = rate
	if cbr then
		local psize = PKT_SIZE
		-- cbr      => mbit/s        => bit/1000ns
		-- psize    => b/p           => 8bit/p
		return 8000 * psize / cbr -- => ns/p
	end
end

function loadSlave(sendQueue, recvQueue, sendQueueLimiter)
	local mem = memory.createMemPool(function(buf)
		fillUdpPacket(buf)
	end)
	local bufs = mem:bufArray()
	
	local sctr = stats:newDevTxCounter(sendQueue, "plain")
	local rctr = stats:newDevRxCounter(recvQueue, "plain")
	while mg.running() do
		bufs:alloc(PKT_SIZE)
		bufs:offloadUdpChecksums()
		sendQueue:send(bufs)
		sctr:update()
		rctr:update()
	end
	sctr:finalize()
	rctr:finalize()
end

function txTimestamper(queue, time, tsLoad)
	local mem = memory.createMemPool(function(buf)
		fillTsUdpPacket(buf)
	end)
	mg.sleepMillis(1000) -- ensure that the load task is running
	local bufs = mem:bufArray(1)
	local rateLimit = timer:new(tsLoad) -- 10pps timestamped packets
	local runtime = nil
	if time > 0 then
		runtime = timer:new(time)
	end
	local i = 0
	while mg.running() and (not runtime or runtime:running()) do
		if i > 0 and (i % 50000) == 0 then
			log:info("Sent " .. i .. " timestamped packets")
		end
		bufs:alloc(PKT_SIZE)
		queue:sendWithTimestamp(bufs, 14+20+8+6)
		rateLimit:wait()
		rateLimit:reset()
		i = i + 1
	end
	log:info("Sent " .. i .. " timestamped packets")
	mg.sleepMillis(500)
	mg.stop()
end


local function isTimestampPacket(pkt)
	if pkt:getIPPacket() and pkt:getIPPacket().ip4.protocol == 4 then
		ipipPkt = pkt.getIPIPPacket()
		if ipipPkt.nestedIp4:getSrcString() == TS_SRC_IP and
		   ipipPkt.nestedIp4:getDstString() == TS_DST_IP and
		   ipipPkt.nestedIp4.protocol == ip.PROTO_UDP then
			return true
		end
	end

	return false
end

local function getTimestampFromPacket(pkt, offset)
	return uint64Ptr(ffi.cast("void*", pkt:getBytes() + offset))[0]
end


function rxTimestamper(queue)
	local tscFreq = mg.getCyclesFrequency()
	local bufs = memory.bufArray(64)

	local results = {}
	local rxts = {}
	while mg.running() do
		local numPkts = queue:recvWithTimestamps(bufs)
		for i = 1, numPkts do
				local rxTs = bufs[i].udata64
				local txTs = getTimestampFromPacket(bufs[i], 14+20+20+8+6)
				if tonumber(txTs) ~= 0 then
					results[#results + 1] = tonumber(rxTs - txTs) / tscFreq * 10^9 -- to nanoseconds
					rxts[#rxts + 1] = tonumber(rxTs)
				end
		end
		bufs:free(numPkts)
	end
	local f = io.open("katran-latency-non-opt.txt", "w+")
	for i, v in ipairs(results) do
		f:write(v .. "\n")
	end
	f:close()
end

