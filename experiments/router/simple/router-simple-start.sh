#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PCAP_FILE_PATH="${DIR}"/pcap/yozb_rtr_route_high_loc.pcap

function create_veth {
  for i in `seq 0 $1`;
  do
  	sudo ip netns add ns${i}
  	sudo ip link add veth${i}_ type veth peer name veth${i}
  	sudo ip link set veth${i}_ netns ns${i}
  	sudo ip netns exec ns${i} ip link set dev veth${i}_ up
  	sudo ip link set dev veth${i} up
    sudo ip netns exec ns${i} ifconfig veth${i}_ 192.168.${i}.1/24 promisc
    sudo ip netns exec ns${i} route add default gw 192.168.${i}.254 veth${i}_
    echo -e "${COLOR_GREEN}Namespace ns${i} created.${COLOR_OFF}"
  done
}

function delete_veth {
  for i in `seq 0 $1`;
  do
  	sudo ip link del veth${i} &> /dev/null
  	sudo ip netns del ns${i} &> /dev/null
  done
}

function ping_cycle {
  for i in `seq 0 $1`;
  do
    for j in `seq 0 $1`;
    do
      if [ "$i" -ne "$j" ]; then
        sudo ip netns exec ns$i ping 192.168.$j.1 -c 2 -i 0.5
      fi
    done
  done
}

function stop_tcpreplay_pcap {
    if [ -f ${DIR}/tcpreplay.pid ]
    then
        sudo kill $(cat "$DIR"/tcpreplay.pid)
        echo -e "${COLOR_GREEN}tcpreplay $(cat "$DIR"/tcpreplay.pid) killed.${COLOR_OFF}"
        sudo rm -f ${DIR}/tcpreplay.pid
    else
        echo -e "${COLOR_RED}tcpreplay not running.${COLOR_OFF}"
    fi
}

function start_tcpreplay_pcap {
    if ! command -v tcpreplay &> /dev/null
    then
        echo -e "${COLOR_RED}tcpreplay command could not be found.${COLOR_OFF}"
        echo -e "${COLOR_RED}You can install it by running 'sudo apt install tcpreplay -y'.${COLOR_OFF}"
        exit 1
    fi

    sudo rm -f nohup.out &> /dev/null
    sudo nohup ip netns exec ns0 tcpreplay -l 0 -t -K -i veth0_ ${PCAP_FILE_PATH} &

    # Write tcpdump's PID to a file
    echo $! > ${DIR}/tcpreplay.pid
}

function start_throughput_measurement {
    sudo ip netns exec ns1 ${DIR}/check-speed.sh veth1_ $1
}

function cleanup {
  set +e
  stop_tcpreplay_pcap
  sudo killall tcpreplay &> /dev/null
  #sudo killall polycubed &> /dev/null
  delete_veth 1
  sudo rm -f nohup.out &> /dev/null
}
trap cleanup EXIT

function show_help() {
usage="$(basename "$0") [-q]
Script to start a simple test of Morpheus with the router service

-q  Do not ask for information on the console"
echo "$usage"
echo
}

while getopts :qh option; do
 case "${option}" in
 q)
  QUIET=1
  ;;
 h|\?)
  show_help
  exit 0
 esac
done

TYPE="TC"

sudo polycubectl router del r1 &> /dev/null
delete_veth 1

echo -e "${COLOR_YELLOW}Creating namespaces.${COLOR_OFF}"
create_veth 1
echo -e "${COLOR_GREEN}Namespaces created.\n${COLOR_OFF}"

set -e

echo -e "${COLOR_YELLOW}Creating Polycube router service (r1).${COLOR_OFF}"
sudo polycubectl router add r1 type=$TYPE loglevel=off dyn-opt=true
echo -e "${COLOR_GREEN}Polycube router service created.\n${COLOR_OFF}"

echo -e "${COLOR_YELLOW}Attaching veth ports to router service (r1).${COLOR_OFF}"
sudo polycubectl r1 ports add to_veth0 ip=192.168.0.254/24 mac=f8:f2:1e:b2:43:00 peer=veth0
sudo polycubectl r1 ports add to_veth1 ip=192.168.1.254/24 mac=f8:f2:1e:b2:43:01 peer=veth1
echo -e "${COLOR_GREEN}Veth ports attached.\n${COLOR_OFF}"

# We set up a DROP rule in the FORWARD chain to avoid packets being redirected
# back in the same interface
sudo ip netns exec ns1 iptables -P FORWARD DROP

echo -e "${COLOR_YELLOW}Loading routing table rules to router service (it takes a while).${COLOR_OFF}"

${DIR}/../config/yozb_rtr_route.sh

echo -e "${COLOR_GREEN}Routing table rules loaded.\n${COLOR_OFF}"

echo -e "${COLOR_YELLOW}Let's check if everything is setup correctly.${COLOR_OFF}"
# All the namespaces try to ping each other
ping_cycle 1
echo -e "${COLOR_GREEN}Ping works, let's start the test.\n${COLOR_OFF}"

if [ -z ${QUIET+x} ]; then
  while true; do
      read -p "Do you want to start sending the PACP trace? (y/n) " yn
      case $yn in
          [Yy]* ) break;;
          [Nn]* ) exit;;
          * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_OFF}";;
      esac
  done
else
  sleep 5
fi

start_tcpreplay_pcap
sleep 2

echo -e "${COLOR_GREEN}PCAP send is in progress, let's monitor the throughput.\n${COLOR_OFF}"
start_throughput_measurement 30

echo -e "${COLOR_YELLOW}We now enable Morpheus.${COLOR_OFF}"
sudo polycubectl r1 set start-morpheus=true
echo -e "${COLOR_GREEN}Morpheus enabled, it will start soon optimizing the program.\n${COLOR_OFF}"

sleep 5
echo -e "${COLOR_GREEN}Check the throughput, it will start increasing as soon as Morpheus optimization will be applied.${COLOR_OFF}"
start_throughput_measurement 30

echo -e "${COLOR_GREEN}Test done, let's cleanup the resources.${COLOR_OFF}"

sudo killall polycubed
exit 0
