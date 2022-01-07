#!/bin/bash

echo "Enable intel intel_iommu on grub."

res=$(sudo grep -rnw '/etc/default/grub' -e 'intel_iommu=on')
if [ -z "$res" ]; then
    sudo sed -i -E "s/(GRUB_CMDLINE_LINUX_DEFAULT=\")(.*)(\")/\1\2 intel_iommu=on\3/" /etc/default/grub
    sudo update-grub
fi

echo "Settings updated. Now you should reboot the machine."