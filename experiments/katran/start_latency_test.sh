#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%m-%d-%Y-%T")

declare -a test_type=("optimized" "unoptimized")
declare -a load=("load" "no-load")

source ${DIR}/../config.sh

DUT_TEST_SCRIPT_PATH="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/katran/start_throughput_test_dut.sh
DUT_TEST_SCRIPT_RESULT="${DUT_REMOTE_MORPHEUS_FOLDER}"/experiments/katran/config_result

KATRAN_LATENCY_SCRIPT_ORIGIN="${DIR}"/config/latency/latency-katran.lua
KATRAN_LATENCY_SCRIPT_NON_OPT_ORIGIN="${DIR}"/config/latency/latency-katran-non-opt.lua

KATRAN_LATENCY_SCRIPT_NEW="${DIR}"/config/latency/latency-katran_new.lua
KATRAN_LATENCY_SCRIPT_NON_OPT_NEW="${DIR}"/config/latency/latency-katran-non-opt_new.lua

RESULTS_FOLDER_PATH=${DIR}/results/latency
TEST_DURATION=30

function show_help() {
usage="$(basename "$0") [-h] [-r #runs]
Run Katran latency tests for optimized and unoptimized path

where:
    -h  show this help text
    -r  number of runs for the test"

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
  ${DUT_TEST_SCRIPT_PATH} -l $morpheus_flag
  echo \$? > ${DUT_TEST_SCRIPT_RESULT}
EOF
}

function cleanup {
  set +e
  rm ${KATRAN_LATENCY_SCRIPT_NEW} &> /dev/null
  rm ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW} &> /dev/null
  echo -e "${COLOR_YELLOW}Killing polycubed & perf${COLOR_OFF}"
  cleanup_environment
  trap - EXIT
  exit 0
}

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

cp ${KATRAN_LATENCY_SCRIPT_ORIGIN} ${KATRAN_LATENCY_SCRIPT_NEW} 
sed -i -e 's/<PKTGEN_MAC_IF1>/'${PKTGEN_MAC_IF1}'/g' ${KATRAN_LATENCY_SCRIPT_NEW}
sed -i -e 's/<PKTGEN_MAC_IF2>/'${PKTGEN_MAC_IF2}'/g' ${KATRAN_LATENCY_SCRIPT_NEW}
sed -i -e 's/<DUT_MAC_IF1>/'${DUT_MAC_IF1}'/g' ${KATRAN_LATENCY_SCRIPT_NEW}

cp ${KATRAN_LATENCY_SCRIPT_NON_OPT_ORIGIN} ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW} 
sed -i -e 's/<PKTGEN_MAC_IF1>/'${PKTGEN_MAC_IF1}'/g' ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW}
sed -i -e 's/<PKTGEN_MAC_IF2>/'${PKTGEN_MAC_IF2}'/g' ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW}
sed -i -e 's/<DUT_MAC_IF1>/'${DUT_MAC_IF1}'/g' ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW}


for l in "${load[@]}"; do
  if [ $l == "load" ]; then
    # rate="10Mp/s"
    rate=4
  else
    rate=0
    # rate="10p/s"
  fi 

  for i in $(eval echo "{1..$NUMBER_RUNS}"); do
    echo -e "${COLOR_GREEN}[ INFO ] Running baseline latency test: ${l}, run: ${i} ${COLOR_OFF}"

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
    sudo ${MOONGEN_BUILD_DIR}/MoonGen ${KATRAN_LATENCY_SCRIPT_NEW} 0 0 ${rate} 0.1 ${TEST_DURATION}
    popd

    sudo mv ${MOONGEN_BUILD_DIR}/../katran-latency.txt ${RESULTS_FOLDER_PATH}/results_baseline_latency_${l}_run${i}.csv
  done

  for test in "${test_type[@]}"; do
    # Now let's start the test with Morpheus
    for i in $(eval echo "{1..$NUMBER_RUNS}"); do
      echo -e "${COLOR_GREEN}[ INFO ] Running Morpheus test ${l}: ${test}, run: ${i} ${COLOR_OFF}"

      start_config_remote "-m"

      config_result=$(ssh ${DUT_SERVER_USER}@${DUT_SERVER_IP} "cat ${DUT_TEST_SCRIPT_RESULT}")

      if [ $config_result == 0 ]; then
        echo -e "${COLOR_GREEN}[ INFO ] Configuration on remote server succeded. ${COLOR_OFF}"
      else
        echo -e "${COLOR_RED}[ ERROR ] Error in the configuration script on the remote server ${COLOR_OFF}"
        exit 1
      fi

      sleep 15
      
      echo -e "${COLOR_GREEN}[ INFO ] Starting Moongen latency test. ${COLOR_OFF}"

      if [ -z ${MOONGEN_BUILD_DIR+x} ]; then
        echo -e "${COLOR_RED}[ ERROR ] Moongen is not installed correctly ${COLOR_OFF}"
        exit 1
      fi

      pushd .
      cd ${MOONGEN_BUILD_DIR}/..
      if [ $test == "optimized" ]; then
        sudo ${MOONGEN_BUILD_DIR}/MoonGen ${KATRAN_LATENCY_SCRIPT_NEW} 0 0 ${rate} 0.1 ${TEST_DURATION}
        sudo mv ${MOONGEN_BUILD_DIR}/../katran-latency.txt ${RESULTS_FOLDER_PATH}/results_${test}_latency_${l}_run${i}.csv
      else
        sudo ${MOONGEN_BUILD_DIR}/MoonGen ${KATRAN_LATENCY_SCRIPT_NON_OPT_NEW} 0 0 ${rate} 0.1 ${TEST_DURATION}
        sudo mv ${MOONGEN_BUILD_DIR}/../katran-latency-non-opt.txt ${RESULTS_FOLDER_PATH}/results_${test}_latency_${l}_run${i}.csv
      fi
      popd
    done
  done
done

echo -e "${COLOR_GREEN}[ INFO ] Latency test completed. ${COLOR_OFF}"

exit 0