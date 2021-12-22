#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%m-%d-%Y-%T")

declare -a test_type=("high_loc" "low_loc" "no_loc")

#set -x 
source ${DIR}/../config.sh

DUT_TEST_SCRIPT_PATH="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/switch/start_throughput_test_dut.sh
DUT_TEST_SCRIPT_RESULT="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/switch/config_result
PKTGEN_TEST_SCRIPT_PATH="${DIR}"/start_throughput_test_pktgen.sh

RESULTS_FOLDER_PATH=${DIR}/results/throughput

function show_help() {
usage="$(basename "$0") [-h] [-r #runs]
Run L2 Switch tests with different traffic localities using remote server

where:
    -h  show this help text
    -r  number of runs for the test"

echo "$usage"
}

function cleanup_environment {
ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} << EOF
  sudo killall polycubed
  sleep 5
  sudo killall polycubed
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
  sudo rm results_port_0.csv &> /dev/null
  sudo rm results_port_1.csv &> /dev/null
  echo -e "${COLOR_YELLOW}Killing polycubed${COLOR_OFF}"
  cleanup_environment
}

#set -e

while getopts :r:h option; do
 case "${option}" in
 h|\?)
	show_help
	exit 0
	;;
 r) NUMBER_RUNS=${OPTARG}
	;;
 :)
    echo "Option -$OPTARG requires an argument." >&2
    show_help
    exit 0
    ;;
 esac
done

if [ -z ${NUMBER_RUNS+x} ]; then
    NUMBER_RUNS=5
    echo -e "${COLOR_YELLOW}[ INFO ] Number of runs not specified, using default value: ${NUMBER_RUNS}${COLOR_OFF}"
fi

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
sudo_nopass_enabled=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} sudo -n true &> /dev/null; echo "$?")
if [ $sudo_nopass_enabled == 0 ]; then
  echo -e "${COLOR_GREEN}[ INFO ] Sudo without password is enabled on remote machine. ${COLOR_OFF}"
else
  echo -e "${COLOR_RED}[ ERROR ] You should enable sudo without password on the remote DUT to continue with this script ${COLOR_OFF}"
  exit 1
fi

trap cleanup EXIT

set -e

TEST_RESULT_DIR=${RESULTS_FOLDER_PATH}

sudo rm -rf ${TEST_RESULT_DIR} &> /dev/null
mkdir -p ${TEST_RESULT_DIR} &> /dev/null

for test in "${test_type[@]}"; do
  for i in $(eval echo "{1..$NUMBER_RUNS}"); do
    echo -e "${COLOR_GREEN}[ INFO ] Running baseline test: ${test}, run: ${i} ${COLOR_OFF}"

    start_config_remote

    config_result=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} "cat ${DUT_TEST_SCRIPT_RESULT}")

    if [ $config_result == 0 ]; then
      echo -e "${COLOR_GREEN}[ INFO ] Configuration on remote server succeded. ${COLOR_OFF}"
    else
      echo -e "${COLOR_RED}[ ERROR ] Error in the configuration script on the remote server ${COLOR_OFF}"
      exit 1
    fi

    sleep 10
    chmod +x ${PKTGEN_TEST_SCRIPT_PATH}
    ${PKTGEN_TEST_SCRIPT_PATH} -t ${test} -o results_baseline_${test}_run${i}.csv -C ${RESULTS_FOLDER_PATH}
  done

  # Now let's start the test with Morpheus
  for i in $(eval echo "{1..$NUMBER_RUNS}"); do
    echo -e "${COLOR_GREEN}[ INFO ] Running Morpheus test: ${test}, run: ${i} ${COLOR_OFF}"

    start_config_remote "-m"

    config_result=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} "cat ${DUT_TEST_SCRIPT_RESULT}")

    if [ $config_result == 0 ]; then
      echo -e "${COLOR_GREEN}[ INFO ] Configuration on remote server succeded. ${COLOR_OFF}"
    else
      echo -e "${COLOR_RED}[ ERROR ] Error in the configuration script on the remote server ${COLOR_OFF}"
      exit 1
    fi

    chmod +x ${PKTGEN_TEST_SCRIPT_PATH}
    ${PKTGEN_TEST_SCRIPT_PATH} -t ${test} -o results_morpheus_${test}_run${i}.csv -C ${RESULTS_FOLDER_PATH}
  done
done

exit 0