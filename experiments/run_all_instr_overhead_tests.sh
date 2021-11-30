#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a services=("router" "bpf-iptables")

function show_help() {
usage="$(basename "$0") [-h] [-r #runs]
Script to run all the tests to calculate the instrumentation overhead

where:
    -h  show this help text
    -r  number of runs for the test"

echo "$usage"
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

echo -e "${COLOR_GREEN}[ INFO ] Starting all the experiments, this will take some time! ${COLOR_OFF}"


for service in "${services[@]}"; do
    echo -e "${COLOR_GREEN}[ INFO ] Running test for service: $service \n\n${COLOR_OFF}"
    chmod +x ${DIR}/${service}/start_instr_overhead_test.sh
    ${DIR}/${service}/start_instr_overhead_test.sh -r ${NUMBER_RUNS}
    echo -e "${COLOR_GREEN}[ INFO ] Test for service: $service done! ${COLOR_OFF}"
done

echo -e "${COLOR_GREEN}[ INFO ] All tests are completed. Yeah! ${COLOR_OFF}"
