#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%m-%d-%Y-%T")

source ${DIR}/../config.sh

DUT_TEST_SCRIPT_PATH="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/router/start_throughput_test_dut.sh
DUT_TEST_SCRIPT_RESULT="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/router/config_result

ROUTER_DYNAMIC_SCRIPT_ORIGIN="${DIR}"/config/dynamic_traffic/replay_pcap_dynamic_test.lua

RESULTS_FOLDER_PATH=${DIR}/results/dynamic_traffic
TEST_DURATION=30

PLOT_DATA_FOLDER="${DIR}"/../plot/data/eval-dynamic-traffic/

PCAP_NO_LOC="${DIR}"/pcap/router_no_loc.pcap
PCAP_HIGH_LOC1="${DIR}"/pcap/router_high_loc.pcap
PCAP_HIGH_LOC2="${DIR}"/pcap/router_high_loc2.pcap

function show_help() {
usage="$(basename "$0") [-h]
Run Router latency tests for optimized and unoptimized path

where:
    -h  show this help text"

echo "$usage"
}

function cleanup_environment {
ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} << EOF
  sudo killall polycubed &> /dev/null
  sleep 5
  sudo killall polycubed &> /dev/null
EOF
}

function start_config_remote {
local morpheus_flag=$1
ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} << EOF
  chmod +x ${DUT_TEST_SCRIPT_PATH}
  ${DUT_TEST_SCRIPT_PATH} $morpheus_flag
  echo \$? > ${DUT_TEST_SCRIPT_RESULT}
EOF
}

function cleanup {
  set +e
  echo -e "${COLOR_YELLOW}Killing polycubed${COLOR_OFF}"
  cleanup_environment
  trap - EXIT
  exit 0
}

while getopts :h option; do
 case "${option}" in
 h|\?)
	show_help
	exit 0
	;;
 :)
    echo "Option -$OPTARG requires an argument." >&2
    show_help
    exit 0
    ;;
 esac
done

# Check if sudo without password is enabled on this server
sudo -n true &> /dev/null
if [ $? == 0 ]; then
  echo -e "${COLOR_GREEN}[ INFO ] Sudo without password is enabled. ${COLOR_OFF}"
else
  echo -e "${COLOR_RED}[ ERROR ] You should enable sudo without password to continue with this script ${COLOR_OFF}"
  exit 1
fi

# Check if the server can connect without password
ssh -o PasswordAuthentication=no -o BatchMode=yes ${DUT_SERVER_USER}@${DUT_SERVER_IP} exit &>/dev/null
if [ $? == 0 ]; then
  echo -e "${COLOR_GREEN}[ INFO ] Can connect: let's continue. ${COLOR_OFF}"
else
  echo -e "${COLOR_RED}[ ERROR ] This client can connect to the DUT without password. ${COLOR_OFF}"
  exit 1
fi

# Check if sudo without password is enabled on the remote server
sudo_nopass_enabled=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} << EOF
sudo -n true &> /dev/null; echo \$?
EOF
)
if [ $sudo_nopass_enabled == 0 ]; then
  echo -e "${COLOR_GREEN}[ INFO ] Sudo without password is enabled on remote machine. ${COLOR_OFF}"
else
  echo -e "${COLOR_RED}[ ERROR ] You should enable sudo without password on the remote DUT to continue with this script ${COLOR_OFF}"
  exit 1
fi

trap cleanup EXIT SIGINT

set -e

TEST_RESULT_DIR=${RESULTS_FOLDER_PATH}

sudo rm -rf ${TEST_RESULT_DIR} &> /dev/null
mkdir -p ${TEST_RESULT_DIR} &> /dev/null

echo -e "${COLOR_GREEN}[ INFO ] Running Baseline dynamic traffic test ${COLOR_OFF}"

start_config_remote 

config_result=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} "cat ${DUT_TEST_SCRIPT_RESULT}")

if [ $config_result == 0 ]; then
    echo -e "${COLOR_GREEN}[ INFO ] Configuration on remote server succeded. ${COLOR_OFF}"
else
    echo -e "${COLOR_RED}[ ERROR ] Error in the configuration script on the remote server ${COLOR_OFF}"
    exit 1
fi

sleep 10

echo -e "${COLOR_GREEN}[ INFO ] Starting Moongen latency test. ${COLOR_OFF}"

if [ -z ${MOONGEN_BUILD_DIR+x} ]; then
    echo -e "${COLOR_RED}[ ERROR ] Moongen is not installed correctly ${COLOR_OFF}"
    exit 1
fi

pushd .
cd ${MOONGEN_BUILD_DIR}/..
sudo ${MOONGEN_BUILD_DIR}/MoonGen ${ROUTER_DYNAMIC_SCRIPT_ORIGIN} 0 1 -f ${PCAP_NO_LOC} -f ${PCAP_HIGH_LOC1} -f ${PCAP_HIGH_LOC2} -l -d 5 -d 5 -d 10 -o router_dynamic_traffic.csv
popd

sudo mv ${MOONGEN_BUILD_DIR}/../router_dynamic_traffic.csv ${RESULTS_FOLDER_PATH}/results_dynamic_traffic_baseline.csv


echo -e "${COLOR_GREEN}[ INFO ] Latency test completed. ${COLOR_OFF}"


echo -e "${COLOR_GREEN}[ INFO ] Running Morpheus dynamic traffic test ${COLOR_OFF}"

start_config_remote "-m"

config_result=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} "cat ${DUT_TEST_SCRIPT_RESULT}")

if [ $config_result == 0 ]; then
    echo -e "${COLOR_GREEN}[ INFO ] Configuration on remote server succeded. ${COLOR_OFF}"
else
    echo -e "${COLOR_RED}[ ERROR ] Error in the configuration script on the remote server ${COLOR_OFF}"
    exit 1
fi

sleep 10

echo -e "${COLOR_GREEN}[ INFO ] Starting Moongen latency test. ${COLOR_OFF}"

if [ -z ${MOONGEN_BUILD_DIR+x} ]; then
    echo -e "${COLOR_RED}[ ERROR ] Moongen is not installed correctly ${COLOR_OFF}"
    exit 1
fi

pushd .
cd ${MOONGEN_BUILD_DIR}/..
sudo ${MOONGEN_BUILD_DIR}/MoonGen ${ROUTER_DYNAMIC_SCRIPT_ORIGIN} 0 1 -f ${PCAP_NO_LOC} -f ${PCAP_HIGH_LOC1} -f ${PCAP_HIGH_LOC2} -l -d 5 -d 5 -d 10 -o router_dynamic_traffic.csv
popd

sudo mv ${MOONGEN_BUILD_DIR}/../router_dynamic_traffic.csv ${RESULTS_FOLDER_PATH}/results_dynamic_traffic_morpheus.csv

sudo rm -rf ${PLOT_DATA_FOLDER} &> /dev/null
mkdir -p ${PLOT_DATA_FOLDER} &> /dev/null
sudo cp -f ${RESULTS_FOLDER_PATH}/results_dynamic_traffic_baseline.csv ${PLOT_DATA_FOLDER}
sudo cp -f ${RESULTS_FOLDER_PATH}/results_dynamic_traffic_morpheus.csv ${PLOT_DATA_FOLDER}

echo -e "${COLOR_GREEN}[ INFO ] Dynamic traffic test completed. ${COLOR_OFF}"

exit 0
