#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%m-%d-%Y-%T")

PCAP_PATH=${DIR}/pcap
RESULTS_FOLDER_PATH=${DIR}/results/throughput

OUT_FILE=results.csv
TEST_DURATION=60

#######################################
#     Specific Test Configuration     #
#######################################
function generate_test_configuration() {
local test_name=$1
if [ $test_name == "high_loc" ]; then
  PCAP_FILE_NAME=${PCAP_PATH}/fw1_ruleset_trace_high_loc.pcap
elif [ $test_name == "low_loc" ]; then
  PCAP_FILE_NAME=${PCAP_PATH}/fw1_ruleset_trace_low_loc.pcap
elif [ $test_name == "no_loc" ]; then
  PCAP_FILE_NAME=${PCAP_PATH}/fw1_ruleset_trace_no_loc.pcap
else
  echo "Test case not supported"
  exit 1
fi
}


function show_help() {
usage="$(basename "$0") [-h] [-t test_name] [-o output_file] [-d duration] [-C results_dir]
Run bpf-iptables test with different traffic localities

where:
    -h  show this help text
    -t  test name (high_loc, low_loc, no_loc)
    -d  duration of the test (in sec) [default is 60sec]
    -o  output file name
    -C  path to the results dir where to place the files"

echo "$usage"
}


while getopts :t:o:d:C:h option; do
 case "${option}" in
 h|\?)
	show_help
	exit 0
	;;
 t) TEST_NAME=${OPTARG}
	;;
 o) OUT_FILE=${OPTARG}
	;;
 d) TEST_DURATION=${OPTARG}
	;;
 C) RESULTS_FOLDER_PATH=${OPTARG}
	;;
 :)
    echo "Option -$OPTARG requires an argument." >&2
    show_help
    exit 0
    ;;
 esac
done

if [ -z ${TEST_NAME+x} ]; then
  echo -e "${COLOR_RED}[ ERROR ] You should specify the name of the test with the -t option ${COLOR_OFF}"
	show_help
	exit 1
fi

set +e

generate_test_configuration ${TEST_NAME}

source ${DIR}/../config.sh

if [ -z ${PCI_ID_DEV1+x} ]; then
    echo -e "${COLOR_RED}[ ERROR ] Unable to source config file: ${DIR}/../config.sh ${COLOR_OFF}"
	exit 1
fi

echo -e "${COLOR_GREEN}[ PKTGEN ] Starting BPF-iptables test: ${TEST_NAME} ${COLOR_OFF}"

sudo dpdk-replay --nbruns 100000000 --numacore ${NUMA_NODE_ID} --timeout ${TEST_DURATION} --stats ${PCI_ID_DEV1},${PCI_ID_DEV2} \
                 --write-csv ${PCAP_FILE_NAME} ${PCI_ID_DEV1}

mkdir -p ${RESULTS_FOLDER_PATH} &> /dev/null
sudo rm -f results_port_0.csv &> /dev/null
sudo mv -f results_port_1.csv ${RESULTS_FOLDER_PATH}/${OUT_FILE} &> /dev/null

echo -e "${COLOR_GREEN}[ PKTGEN ] BPF-iptables test: ${TEST_NAME} completed ${COLOR_OFF}"

exit 0