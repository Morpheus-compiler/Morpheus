#!/bin/bash
echo "Upgrade to kernel version 5.12."

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

popd