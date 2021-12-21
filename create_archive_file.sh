#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
    ARCHIVE_NAME=morpheus.tar.gz
else
    ARCHIVE_NAME="$1"
fi

pushd .
cd $DIR
rm morpheus.tar.gz &> /dev/null
rm -rf polycube
git submodule init
git submodule update --recursive

./download_pcaps.sh
git-archive-all --force-submodules \
                --include=experiments/bpf-iptables/bpf-iptables-pcap.tar.gz \
                --include=experiments/router/router-pcap.tar.gz \
                --include=experiments/switch/switch-pcap.tar.gz \
                --include=experiments/katran/katran-pcap.tar.gz \
                ${ARCHIVE_NAME}

popd