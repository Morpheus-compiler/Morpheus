#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${COLOR_GREEN}Enable intel intel_iommu on grub.${COLOR_OFF}"

sudo sed -i -E "s/(GRUB_CMDLINE_LINUX_DEFAULT=\")(.+)(\")/\1\2 intel_iommu=on\3/" /etc/default/grub
sudo update-grub

echo -e "${COLOR_GREEN}Settings updated. Now you should reboot the machine.${COLOR_OFF}"