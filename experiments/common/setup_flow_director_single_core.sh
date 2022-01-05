#!/bin/bash
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

sudo ethtool -K $1 ntuple on

res=$(sudo ethtool -k $1 | grep "ntuple-filters: on")
if [ -z "$res" ]; then
  echo -e "${COLOR_RED}Warning: The script sets the rules to perform the single core tests${COLOR_OFF}"
  echo -e "${COLOR_RED}The interface $1 does not support it. Results may be unpredictable${COLOR_OFF}"
  exit 0
fi

sudo ethtool --features $1 ntuple off
sudo ethtool --features $1 ntuple on
sudo ethtool -N $1 flow-type udp4 dst-ip 192.168.1.1 m 255.255.255.255 action 1
sudo ethtool -N $1 flow-type tcp4 dst-ip 192.168.1.1 m 255.255.255.255 action 1
