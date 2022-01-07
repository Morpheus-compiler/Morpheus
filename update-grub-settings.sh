#!/bin/bash

function show_help() {
usage="$(basename "$0") [-q]
Script to enable intel_iommu on the grub settings

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

echo "Enable intel_iommu on grub."

res=$(sudo grep -rnw '/etc/default/grub' -e 'intel_iommu=on')
if [ -z "$res" ]; then
    sudo sed -i -E "s/(GRUB_CMDLINE_LINUX_DEFAULT=\")(.*)(\")/\1\2 intel_iommu=on\3/" /etc/default/grub
    sudo update-grub

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
fi

echo "Settings updated."