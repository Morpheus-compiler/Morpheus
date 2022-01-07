#!/bin/bash

echo "Enable intel intel_iommu on grub."

sudo sed -i -E "s/(GRUB_CMDLINE_LINUX_DEFAULT=\")(.*)(\")/\1\2 intel_iommu=on\3/" /etc/default/grub
sudo update-grub

echo "Settings updated. Now you should reboot the machine."