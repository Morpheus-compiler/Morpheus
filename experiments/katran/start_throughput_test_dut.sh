#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%m-%d-%Y-%T")

CONFIG_FOLDER=${DIR}/config

SET_IRQ_SCRIPT=${DIR}/../common/setup_flow_director_single_core.sh

MORPHEUS_CONFIG_FILE=/etc/morpheus/morpheus.yaml

function show_help() {
usage="$(basename "$0") [-h] [-m] [-l] [-c config_file_path]
Run Katran program and configure it with a set of VIPs and Backend servers

where:
    -h  show this help text
    -m  run test with Morpheus enabled
    -l  use ruleset for the latency test
    -c  path to the Morpheus configuration file"

echo "$usage"
}

# Kill polycubed, and wait all services to be unloaded and process to be completely killed
function polycubed_kill_and_wait {
  set +x
  echo "killing polycubed ..."
  sudo pkill polycubed > /dev/null 2>&1
  done=0
  i=0
  while : ; do
    sleep 1
    alive=$(ps -el | grep polycubed)
    if [ -z "$alive" ]; then
      done=1
    else
      sudo pkill polycubed > /dev/null 2>&1
    fi

    i=$((i+1))

    if [ "$done" -eq 1 ]; then
        echo "killing polycubed in $i seconds"
        break
    fi
  done
}


function set_irq_affinity {
    sudo $SET_IRQ_SCRIPT $1
}

#set -e

while getopts :c:mlh option; do
 case "${option}" in
 h|\?)
	show_help
	exit 0
	;;
 m) MORPHEUS_ENABLED=1
	;;
 l) LATENCY_RULESET=1
	;;
 c) MORPHEUS_CUSTOM_CONFIG_FILE=${OPTARG}
  ;;
 :)
    echo "Option -$OPTARG requires an argument." >&2
    show_help
    exit 0
    ;;
 esac
done

trap polycubed_kill_and_wait err

set +e
polycubed_kill_and_wait
set -e

sudo rm -f "${MORPHEUS_CONFIG_FILE}" &> /dev/null

if [ -n "$MORPHEUS_CUSTOM_CONFIG_FILE" ]; then
  if test -f "$MORPHEUS_CUSTOM_CONFIG_FILE"; then
    sudo cp -f ${MORPHEUS_CUSTOM_CONFIG_FILE} ${MORPHEUS_CONFIG_FILE}
  else
    echo -e "${COLOR_RED}[ DUT ] File ${MORPHEUS_CUSTOM_CONFIG_FILE} does not exist. ${COLOR_OFF}"    
    exit 1
  fi
fi

echo -e "${COLOR_GREEN}[ DUT ] Starting Morpheus on a tmux session${COLOR_OFF}"
echo -e "${COLOR_GREEN}[ DUT ] You can use 'tmux attach -d -t morpheus' to see the output${COLOR_OFF}"

tmux new-session -d -s morpheus 'sudo polycubed'
sleep 10

source ${DIR}/../config.sh

if [ -z ${IF1_NAME+x} ]; then
    echo -e "${COLOR_RED}[ ERROR ] Unable to source config file: ${DIR}/../config.sh ${COLOR_OFF}"
	exit 1
fi

sudo ifconfig ${IF1_NAME} up promisc
sudo ifconfig ${IF2_NAME} up promisc

echo -e "${COLOR_YELLOW}[ DUT ] Creating Katran service.${COLOR_OFF}"
if [ -z ${MORPHEUS_ENABLED+x} ]; then
  sudo polycubectl katran add k1 loglevel=off enableHc=false type=xdp_drv defaultMac=${PKTGEN_MAC_IF1} lruSize=10000 forwardingCores=\"1\" dyn-opt=false
else
  sudo polycubectl katran add k1 loglevel=off enableHc=false type=xdp_drv defaultMac=${PKTGEN_MAC_IF1} lruSize=10000 forwardingCores=\"1\" dyn-opt=true
fi
echo -e "${COLOR_GREEN}[ DUT ] Polycube Katran service created.\n${COLOR_OFF}"

echo -e "${COLOR_YELLOW}[ DUT ] Attaching ports.${COLOR_OFF}"
sudo polycubectl k1 ports add p1 peer=${IF1_NAME}
echo -e "${COLOR_GREEN}[ DUT ] Ports attached.\n${COLOR_OFF}"

echo -e "${COLOR_YELLOW}[ DUT ] Loading VIP and backend servers to Katran service (it takes a while).${COLOR_OFF}"

if [ -z ${LATENCY_RULESET+x} ]; then
  ${DIR}/config/load_vip_list.sh vip_list1.txt 100
else
  ${DIR}/config/load_vip_list_latency.sh vip_list_latency.txt 100
fi

echo -e "${COLOR_GREEN}[ DUT ] Katran backend servers loaded.\n${COLOR_OFF}"

set_irq_affinity ${IF1_NAME}

if [ -z ${MORPHEUS_ENABLED+x} ]; then
  echo -e "${COLOR_YELLOW}[ DUT ] Running without Morpheus.\n${COLOR_OFF}"
else
  echo -e "${COLOR_GREEN}[ DUT ] Enabling Morpheus.\n${COLOR_OFF}"
  set -x
  sudo polycubectl k1 set start-morpheus=true
fi

set +x
echo -e "${COLOR_GREEN}[ DUT ] Setup completed. Now you can start the packet generator.${COLOR_OFF}"

exit 0