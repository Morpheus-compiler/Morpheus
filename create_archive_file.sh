#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

POLYCUBE_GIT_REPO_URL=https://github.com/Morpheus-compiler/polycube.git
MORPHEUS_POLYCUBE_BRANCH=morpheus

pushd .
cd $DIR
rm morpheus.tar.gz
rm -rf polycube
git clone --branch ${MORPHEUS_POLYCUBE_BRANCH} ${POLYCUBE_GIT_REPO_URL} polycube

pushd .
cd polycube
git-archive-all --force-submodules polycube.tar.gz
mv polycube.tar.gz ..
popd

./download_pcaps.sh
git-archive-all --include=polycube.tar.gz --include=experiments/bpf-iptables/bpf-iptables-pcap.tar.gz \
                --include=experiments/router/router-pcap.tar.gz \
                --include=experiments/switch/switch-pcap.tar.gz \
                --include=experiments/katran/katran-pcap.tar.gz \
                morpheus.tar.gz

popd