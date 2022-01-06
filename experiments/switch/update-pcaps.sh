#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PCAP_PATH=${DIR}/pcap

source ${DIR}/../config.sh

for FILE in ${PCAP_PATH}/*; do 
    if [[ ! $PKTGEN_MAC_IF1 =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]]; then
        echo -e "${COLOR_RED}[ ERROR ] PKTGEN_MAC_IF1: ${PKTGEN_MAC_IF1} is not valid. ${COLOR_OFF}"
        exit 1
    fi

    if [[ $FILE == *"receiver"* ]]; then
        tcprewrite --enet-dmac=${PKTGEN_MAC_IF1} --infile=${FILE} --outfile=${FILE}.new
        mv ${FILE}.new ${FILE}
        echo -e "${COLOR_GREEN}[ INFO ] File ${FILE} rewritten. ${COLOR_OFF}"
    elif [[ $FILE == *"sender"* ]]; then
        tcprewrite --enet-smac=${PKTGEN_MAC_IF1} --infile=${FILE} --outfile=${FILE}.new
        mv ${FILE}.new ${FILE}
        echo -e "${COLOR_GREEN}[ INFO ] File ${FILE} rewritten. ${COLOR_OFF}"
    fi
done