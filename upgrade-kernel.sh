#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${COLOR_GREEN}Upgrade to kernel version 5.12.${COLOR_OFF}"

pushd .
mkdir -p /tmp/kernel_v5_12
cd /tmp/kernel_v5_12

wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-headers-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-headers-5.12.19-051219_5.12.19-051219.202107201136_all.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-image-unsigned-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-modules-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb

sudo dpkg -i ./*

sudo apt --fix-broken install
sudo update-grub
echo -e "${COLOR_GREEN}New kernel installed. You can change the configuration from GRUB or simply reboot the machine with the new kernel${COLOR_OFF}"

popd