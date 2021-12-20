#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bpf_iptables_PCAP_URL=https://github.com/Morpheus-compiler/Morpheus/releases/download/v0.1/bpf-iptables-pcap.tar.gz
katran_PCAP_URL=https://github.com/Morpheus-compiler/Morpheus/releases/download/v0.1/katran-pcap.tar.gz
router_PCAP_URL=https://github.com/Morpheus-compiler/Morpheus/releases/download/v0.1/router-pcap.tar.gz
switch_PCAP_URL=https://github.com/Morpheus-compiler/Morpheus/releases/download/v0.1/switch-pcap.tar.gz

declare -a services=("router" "bpf-iptables" "switch" "katran")

for service in "${services[@]}"; do
    pushd .
    cd "${DIR}/experiments/${service}"
    if [ ${service} == "bpf-iptables" ]; then
        url_var_name=bpf_iptables_PCAP_URL
    else
        url_var_name=${service}_PCAP_URL
    fi
    
    if [ ! -f "${service}-pcap.tar.gz" ]; then
        wget ${!url_var_name}
    fi
    rm -rf "${DIR}/experiments/${service}/pcap"
    mkdir -p "${DIR}/experiments/${service}/pcap"
    tar -xf ${service}-pcap.tar.gz -C "${DIR}/experiments/${service}/pcap" --strip-components 1
    #rm ${service}-pcap.tar.gz
    popd
done