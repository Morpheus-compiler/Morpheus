#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DPDK_REPLAY_GIT_REPO_URL=https://github.com/sebymiano/dpdk-burst-replay.git
DPDK_REPLAY_GIT_BRANCH=morpheus
MOONGEN_GIT_REPO_URL=https://github.com/emmericp/MoonGen.git
MOOGEN_COMMIT_SHA=25c61ee76b9ca30b83ecdeef8af2c7f89625cb4e

UBUNTU_SUGGESTED_VERSION=20.04

DEPS_DIR=$DIR/deps

function print_system_info {
  echo -e "${COLOR_GREEN}***********************SYSTEM INFO*************************************"
  echo -e "kernel version:" "$(uname -r)"
  echo -e "linux release info:" "$(lsb_release -d | awk '{print $2, $3}')"
  echo -e "${COLOR_OFF}"
}

function error_message {
  set +x
  echo
  echo -e "${COLOR_RED}Error during installation${COLOR_OFF}"
  print_system_info
  exit 1
}

function success_message {
  set +x
  echo
  echo -e "${COLOR_GREEN}Installation completed successfully${COLOR_OFF}"
  exit 0
}

function check_ubuntu_version {
  CURRENT_UBUNTU_VERSION=$(lsb_release -rs)
  if [[ "${CURRENT_UBUNTU_VERSION}" == "${UBUNTU_SUGGESTED_VERSION}" ]]; then
    echo -e "${COLOR_GREEN} Compatible Ubuntu version ${COLOR_OFF}"
  else
    echo -e "${COLOR_RED} WARNING: Ubuntu version: $CURRENT_UBUNTU_VERSION < Suggested version: $UBUNTU_SUGGESTED_VERSION ${COLOR_OFF}"
    echo -e "${COLOR_RED} You can still try to install Morpheus, but the scripts or the installation may fail ${COLOR_OFF}"
    sleep 2
  fi
}

function download_and_install_dpdk {
  DPDK_DIR=${DEPS_DIR}/dpdk

  if [ -f "$DEPS_DIR/dpdk_installed" ]; then
      return
  fi

  rm -rf "$DPDK_DIR"

  pushd .
  cd "$DEPS_DIR"
  echo -e "${COLOR_GREEN}[ INFO ] Download DPDK 20.11.3 LTS ${COLOR_OFF}"
  mkdir -p "$DPDK_DIR"
  wget https://fast.dpdk.org/rel/dpdk-20.11.3.tar.xz
  tar -xvf dpdk-20.11.3.tar.xz -C "$DPDK_DIR" --strip-components 1
  rm dpdk-20.11.3.tar.xz

  cd "$DPDK_DIR"
  meson build
  cd build
  ninja
  $SUDO ninja install
  sudo ldconfig

  echo -e "${COLOR_GREEN}DPDK is installed ${COLOR_OFF}"
  popd

  touch "${DEPS_DIR}/dpdk_installed"
}

function configure_dpdk_hugepages {
  DPDK_DIR=${DEPS_DIR}/dpdk

  pushd .
  cd "${DPDK_DIR}"/usertools

  $SUDO ./dpdk-hugepages.py -p 1G --setup 10G

  popd
}

function configure_dpdk_ports {
  DPDK_DIR=${DEPS_DIR}/dpdk

  set +e
  pushd .
  cd "${DPDK_DIR}"/usertools

  $SUDO ./dpdk-devbind.py -s

  echo -e "${COLOR_GREEN}Please set the PCI dev id of the ports to configure (separated by space).${COLOR_OFF}"

  read -r -p "PCI DEV IDS: " PCI_DEV_IDS

  echo -e "${COLOR_YELLOW}If it fails, make sure you have the intel_iommu=on enable on /etc/default/grub.${COLOR_OFF}"
  echo -e "${COLOR_YELLOW}Otherwise, you can manually bind the ports to the igb_uio driver.${COLOR_OFF}"
  $SUDO ./dpdk-devbind.py --bind=vfio-pci ${PCI_DEV_IDS}
  popd
  set -e
}

function configure_dpdk_ports_igb_uio {
  DPDK_KMOD_DIR=${DEPS_DIR}/dpdk-kmods

  set +e
  rm -rf "${DPDK_KMOD_DIR}"
  pushd .
  cd ${DEPS_DIR}
  git clone git://dpdk.org/dpdk-kmods
  cd dpdk-kmods/linux/igb_uio
  make
  sudo modprobe uio
  sudo insmod igb_uio.ko
  popd

  pushd .
  cd "${DPDK_DIR}"/usertools

  $SUDO ./dpdk-devbind.py -s

  echo -e "${COLOR_GREEN}Please set the PCI dev id of the ports to configure (separated by space).${COLOR_OFF}"

  read -r -p "PCI DEV IDS: " PCI_DEV_IDS

  $SUDO ./dpdk-devbind.py --bind=igb_uio ${PCI_DEV_IDS}
  
  popd
  set -e
}


function download_and_install_burst_replay {
  BURST_REPLAY_DIR=${DEPS_DIR}/dpdk-burst-replay

  if [ -f "${DEPS_DIR}/dpdk_burst_replay_installed" ]; then
    return
  fi

  rm -rf "$BURST_REPLAY_DIR"
  pushd .
  cd "$DEPS_DIR"

  echo -e "${COLOR_GREEN}[ INFO ] Cloning DPDK burst replay repo ${COLOR_OFF}"
  git clone --branch ${DPDK_REPLAY_GIT_BRANCH} ${DPDK_REPLAY_GIT_REPO_URL} --depth 1 "$BURST_REPLAY_DIR"
  echo -e "${COLOR_GREEN}[ INFO ] Building DPDK burst replay ${COLOR_OFF}"

  cd "$BURST_REPLAY_DIR"
  autoreconf -i
  ./configure
  make -j "$(getconf _NPROCESSORS_ONLN)"
  sudo make install

  popd

  touch "${DEPS_DIR}/dpdk_burst_replay_installed"
}


function download_and_install_moongen {
  MOONGEN_DIR=${DEPS_DIR}/moongen

  if [ -f "${DEPS_DIR}/moongen_installed" ]; then
    return
  fi

  rm -rf "$MOONGEN_DIR"
  pushd .
  cd "$DEPS_DIR"

  echo -e "${COLOR_GREEN}[ INFO ] Cloning Moongen repo ${COLOR_OFF}"
  git clone ${MOONGEN_GIT_REPO_URL} "$MOONGEN_DIR"
  pushd .
  cd "$MOONGEN_DIR"
  git reset --hard ${MOOGEN_COMMIT_SHA}
  git submodule init
  git submodule update --recursive
  popd
  echo -e "${COLOR_GREEN}[ INFO ] Building Moongen ${COLOR_OFF}"

  cd "$MOONGEN_DIR"
  ./build.sh

  popd

  if [ -z ${MOONGEN_BUILD_DIR+x} ]; then
    echo 'export MOONGEN_BUILD_DIR='${MOONGEN_DIR}'/build' >> ~/.bashrc 
  fi

  touch "${DEPS_DIR}/moongen_installed"
}

trap error_message ERR

function show_help() {
usage="$(basename "$0") [-d] [-q]
Script to setup all the repos needed for the packet generator server

-d  Only setup hugepages and ports for DPDK
-q  Quit setup, do not prompt info"
echo "$usage"
echo
}

while getopts :dqh option; do
 case "${option}" in
 d)
  DPDK_SETUP_ONLY=1
  ;;
 q)
  QUIET=1
  ;;
 h|\?)
  show_help
  exit 0
 esac
done

echo "Use 'setup_pktgen.sh -h' to show advanced installation options."

if ! command -v sudo &> /dev/null
then
    echo "sudo not available"
    DEBIAN_FRONTEND=noninteractive apt install -yq sudo
fi

[ -z ${SUDO+x} ] && SUDO='sudo'

mkdir -p "${DEPS_DIR}"

set -e

$SUDO apt update
PACKAGES=""
PACKAGES+=" git-lfs python3 python3-pip python3-setuptools python3-wheel ninja-build" # DPDK
PACKAGES+=" libnuma-dev libelf-dev libcap-dev libjansson-dev libipsec-mb-dev" # DPDK
PACKAGES+=" autoconf libcsv-dev" # DPDK burst replay
PACKAGES+=" pciutils build-essential cmake linux-headers-$(uname -r) libnuma-dev libtbb2" # Moongen
PACKAGES+=" tmux texlive-font-utils pdf2svg poppler-utils pkg-config net-tools bash tcpreplay"

$SUDO bash -c "DEBIAN_FRONTEND=noninteractive apt-get install -yq $PACKAGES"

if ! command -v meson &> /dev/null
then
  $SUDO pip3 install meson
fi

check_ubuntu_version

if [ -z ${DPDK_SETUP_ONLY+x} ]; then 
  download_and_install_dpdk
  download_and_install_burst_replay
  download_and_install_moongen

  ${DIR}/download_pcaps.sh
fi

echo -e "${COLOR_GREEN}All dependencies installed, let's configure DPDK.${COLOR_OFF}"

if [ -z ${QUIET+x} ]; then
  while true; do
      read -r -p "Would you like to configure the hugepages? (y/n) " yn
      case $yn in
          [Yy]* ) configure_dpdk_hugepages; break;;
          [Nn]* ) exit;;
          * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_OFF}";;
      esac
  done

  echo -e "${COLOR_GREEN}Hugepages created.${COLOR_OFF}"

  echo -e "${COLOR_GREEN}Configuring DPDK ports.${COLOR_OFF}"
  echo -e "${COLOR_YELLOW}Make sure the ports do not have an IP address associated, otherwise the bind will fail.${COLOR_OFF}"

  while true; do
      read -r -p "Would you like to configure the ports (using VFIO driver)? (y/n) " yn
      case $yn in
          [Yy]* ) configure_dpdk_ports; break;;
          [Nn]* ) exit;;
          * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_OFF}";;
      esac
  done

  echo -e "${COLOR_GREEN}Ports configured.${COLOR_OFF}"

  while true; do
      echo -e "${COLOR_RED}Please type yes only if the previous command failed to bind ports to the VFIO driver.${COLOR_OFF}"
      read -r -p "Would you like to configure the ports (using IGB_UIO driver)? (y/n) " yn
      case $yn in
          [Yy]* ) configure_dpdk_ports_igb_uio; break;;
          [Nn]* ) exit;;
          * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_OFF}";;
      esac
  done

  echo -e "${COLOR_GREEN}Ports configured.${COLOR_OFF}"
fi

success_message
