#!/bin/bash

function show_help() {
usage="$(basename "$0") [-q]
Script to update kernel version

-q  Non-interactive mode"
echo "$usage"
echo
}

while getopts :qh option; do
 case "${option}" in
 q)
  QUIET=1
  ;;
 h|\?)
  show_help
  exit 0
 esac
done

echo "Upgrade to kernel version 5.12.19"

res=$(sudo dpkg --list | grep 5.12.19)
if [ -z "$res" ]; then
    pushd .
    mkdir -p /tmp/kernel_v5_12
    cd /tmp/kernel_v5_12

    wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-headers-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb
    wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-headers-5.12.19-051219_5.12.19-051219.202107201136_all.deb
    wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-image-unsigned-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb
    wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.19/amd64/linux-modules-5.12.19-051219-generic_5.12.19-051219.202107201136_amd64.deb

    sudo dpkg -i ./*

    sudo apt --fix-broken install -y
    sudo update-grub
    echo "New kernel installed. You can change the configuration from GRUB or simply reboot the machine with the new kernel"

    if [ -z ${QUIET+x} ]; then
        while true; do
            read -r -p "Would you like to reboot the server to apply the new configuration? (y/n) " yn
            case $yn in
                [Yy]* ) sudo reboot;;
                [Nn]* ) break;;
                * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_OFF}";;
            esac
        done
    else
        # Do not ask anything and reboot
        sudo reboot
    fi

    popd
else
    echo "Kernel v5.12.19 is already installed."
fi
