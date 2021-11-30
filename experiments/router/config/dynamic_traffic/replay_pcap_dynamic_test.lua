--- Replay a pcap file.

local mg      = require "moongen"
local device  = require "device"
local memory  = require "memory"
local stats   = require "stats"
local log     = require "log"
local timer   = require "timer"
local pcap    = require "pcap"
local limiter = require "software-ratecontrol"

function configure(parser)
	parser:argument("tx", "Sender device to use."):args(1):convert(tonumber)
	parser:argument("rx", "Sender device to use."):args(1):convert(tonumber)
	parser:option("-f", "Pcap files to send, in the correct order"):count("*"):target("files")
	parser:option("-r --rate-multiplier", "Speed up or slow down replay, 1 = use intervals from file, default = replay as fast as possible"):default(0):convert(tonumber):target("rateMultiplier")
	parser:option("-s --buffer-flush-time", "Time to wait before stopping MoonGen after enqueuing all packets. Increase for pcaps with a very low rate."):default(10):convert(tonumber):target("bufferFlushTime")
	parser:flag("-l --loop", "Repeat pcap file.")
	parser:option("-d --duration", "Duration for each pcap file."):count("*"):convert(tonumber):target("duration")
	parser:option("-o --output", "Output CSV file where to save resulting rate"):default("rxCounter.csv"):target("outputFile")
	local args = parser:parse()
	return args
end

function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
 end

function master(args)
	local txDev = device.config{port = args.tx, rxQueues = 1}
	local rxDev = device.config{port = args.rx, rxQueues = 1}
	device.waitForLinks()
	-- local rateLimiter = timer:new(0.1488) -- 14.88Mpps
	-- if args.rateMultiplier > 0 then
	-- 	rateLimiter = limiter:new(txDev:getTxQueue(0), "custom")
	-- end
	stats.startStatsTask{txDevices = {txDev}}
	stats.startStatsTask{rxDevices = {rxDev}, format = "CSV", file = args.outputFile}

	for _,v in pairs(args.files) do
		if not file_exists(v) then
			printf("File %s does not exist", v)
			return
		end
	end

	for i,v in pairs(args.files) do
		local duration = 60
		if args.duration[i] ~= nil then duration = args.duration[i] end
		printf("Start sending %s trace with duration %d\n", v, duration)
		local replayer = mg.startTask("replay", txDev:getTxQueue(0), v, args.loop, args.rateMultiplier, args.bufferFlushTime, duration)	
		replayer:wait()
		printf("Finished sending %s trace with duration %d\n", v, duration)
	end

	mg:stop()
	mg.waitForTasks()
end

function replay(queue, file, loop, multiplier, sleepTime, duration)
	local mempool = memory:createMemPool(4096)
	local bufs = mempool:bufArray()
	local pcapFile = pcap:newReader(file)
	local prev = 0
	local linkSpeed = queue.dev:getLinkStatus().speed

	local durationTimer = timer:new(duration)
	local rateLimiter = timer:new(0.0000042) -- 14.88Mpps
    while mg.running() and durationTimer:running() do
	-- while mg.running() do
		local n = pcapFile:read(bufs)
		if n > 0 then
			-- if rateLimiter ~= nil then
			-- 	if prev == 0 then
			-- 		prev = bufs.array[0].udata64
			-- 	end
			-- 	for i = 1, n  do
			-- 		local buf = bufs[i]
			-- 		-- ts is in microseconds
			-- 		local ts = buf.udata64
			-- 		if prev > ts then
			-- 			ts = prev
			-- 		end
			-- 		local delay = ts - prev
			-- 		delay = tonumber(delay * 10^3) / multiplier -- nanoseconds
			-- 		delay = delay / (8000 / linkSpeed) -- delay in bytes
			-- 		buf:setDelay(delay)
			-- 		prev = ts
			-- 	end
			-- end
		else
			if loop then
				pcapFile:reset()
			else
				break
			end
		end
		-- if rateLimiter then
		-- 	rateLimiter:sendN(bufs, n)
		-- else
		queue:sendN(bufs, n)
		rateLimiter:wait()
		rateLimiter:reset()
		-- end
	end
	-- log:info("Enqueued all packets, waiting for %d seconds for queues to flush", sleepTime)
	-- mg.sleepMillisIdle(1000)
end

