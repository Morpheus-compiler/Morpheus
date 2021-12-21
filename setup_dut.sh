#!/bin/bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_OFF='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

POLYCUBE_GIT_REPO_URL=https://github.com/Morpheus-compiler/polycube.git
MORPHEUS_POLYCUBE_BRANCH=morpheus
# That means that suggested kernel is at least 5.12
KERNEL_SUGGESTED_MAJOR_VERSION=5
KERNEL_SUGGESTED_MINOR_VERSION=12

UBUNTU_SUGGESTED_VERSION=20.04

KERNEL_DOWNLOAD_SCRIPT=$DIR/get-verified-tarball.sh
POLYCUBE_ARCHIVE=polycube.tar.gz

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

function check_kernel_version {
  CURRENT_KERNEL_VERSION=$(uname -r | cut -c1-4)
  read -r CURRENT_MAJOR_VERSION CURRENT_MINOR_VERSION <<<"$(uname -r | awk -F '.' '{print $1, $2}')"
  if [ "$CURRENT_MAJOR_VERSION" -lt "$KERNEL_SUGGESTED_MAJOR_VERSION" ] ; then
    echo -e "${COLOR_RED} WARNING: Kernel version: $CURRENT_KERNEL_VERSION < Suggested version: $KERNEL_SUGGESTED_MAJOR_VERSION.$KERNEL_SUGGESTED_MINOR_VERSION ${COLOR_OFF}"
    exit 1
  elif [ "$CURRENT_MAJOR_VERSION" -ge "$KERNEL_SUGGESTED_MAJOR_VERSION" ] && [ "$CURRENT_MINOR_VERSION" -lt "$KERNEL_SUGGESTED_MINOR_VERSION" ] ; then
    echo -e "${COLOR_RED} WARNING: Kernel version: $CURRENT_KERNEL_VERSION < Suggested version: $KERNEL_SUGGESTED_MAJOR_VERSION.$KERNEL_SUGGESTED_MINOR_VERSION ${COLOR_OFF}"
    echo -e "${COLOR_RED} You can still try to install Morpheus, but the results may be different from the ones in the paper ${COLOR_OFF}"
    sleep 2
  else
    echo -e "${COLOR_GREEN}Kernel version: $CURRENT_KERNEL_VERSION > Version Limit: $KERNEL_SUGGESTED_MAJOR_VERSION.$KERNEL_SUGGESTED_MINOR_VERSION ${COLOR_OFF}"
  fi
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

function clone_polycube_repo {
  echo -e "${COLOR_GREEN} Cloning Polycube repository ${COLOR_OFF}"
  $SUDO rm -rf polycube > /dev/null
  git clone --branch ${MORPHEUS_POLYCUBE_BRANCH} --recursive ${POLYCUBE_GIT_REPO_URL} polycube --depth 1
  echo -e "${COLOR_GREEN} Polycube repository cloned ${COLOR_OFF}"
}

function install_polycube_morpheus {
  echo -e "${COLOR_GREEN} Installing Morpheus repository cloned ${COLOR_OFF}"
  cd polycube
  pushd .
    ./scripts/install.sh
  popd

  echo -e "${COLOR_GREEN} Morpheus installed ${COLOR_OFF}"
}

function install_linux_perf_tool {
  echo -e "${COLOR_GREEN} Installing Linux perf tool for kernel $(uname -r) ${COLOR_OFF}"

  # Let's first check if perf is available
  local perf_check1=$(command -v perf &> /dev/null; echo $?)
  local perf_check2=$($SUDO perf --help &> /dev/null; echo $?)

  if [ $perf_check1 -ne 0 ] || [ $perf_check2 -ne 0 ]; then
    echo "perf not found"

    local perf_check3=$($SUDO apt install -yqq -o=Dpkg::Use-Pty=0 linux-tools-common linux-tools-generic linux-tools-$(uname -r) &> /dev/null; echo $?)
    
    if [ $perf_check3 -eq 0 ]; then
      echo -e "${COLOR_GREEN} Linux perf tool installed correctly ${COLOR_OFF}"
      return
    else
      echo -e "${COLOR_YELLOW} Linux perf tool is not installed ${COLOR_OFF}"
    fi
  else
    echo -e "${COLOR_GREEN} Linux perf tool is already installed ${COLOR_OFF}"
    return
  fi

  # If we reach this point, we need to install perf manually
  # Let's start by downloading the kernel
  chmod +x ${KERNEL_DOWNLOAD_SCRIPT}
  ${KERNEL_DOWNLOAD_SCRIPT} $(uname -r | cut -c1-4)

  if [ $? -ne 0 ]; then
    echo -e "${COLOR_RED} Unable to install Linux perf tools for kernel $(uname -r) ${COLOR_OFF}"
    echo -e "${COLOR_RED} You can try to install it manually, otherwise some tests may not work correctly ${COLOR_OFF}"
    return
  fi

  pushd .
  cd $DIR/deps/linux/tools/perf
  make -j "$(getconf _NPROCESSORS_ONLN)"
  $SUDO make install
  $SUDO cp ./perf /usr/local/bin/perf
  popd

  echo -e "${COLOR_GREEN} Linux perf tool installed. ${COLOR_OFF}"
}

trap error_message ERR

function show_help() {
usage="$(basename "$0")
Morpheus installation script"
echo "$usage"
echo
}

while getopts h option; do
 case "${option}" in
 h|\?)
  show_help
  exit 0
 esac
done

echo "Use 'setup_dut.sh -h' to show advanced installation options."

#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v sudo &> /dev/null
then
  echo "sudo not available"
  DEBIAN_FRONTEND=noninteractive apt install -yq sudo
fi

if ! command -v tmux &> /dev/null
then
  echo "tmux not found"
  sudo DEBIAN_FRONTEND=noninteractive apt install -yq tmux
fi

if ! command -v gpgv2 &> /dev/null
then
  echo "gpgv2 not found"
  sudo DEBIAN_FRONTEND=noninteractive apt install -yq gpgv2
fi

sudo DEBIAN_FRONTEND=noninteractive apt install -yq net-tools

[ -z ${SUDO+x} ] && SUDO='sudo'

set -e

pushd .
cd ${DIR}

check_kernel_version
check_ubuntu_version

if git rev-parse --git-dir > /dev/null 2>&1; then
  git submodule init
  git submodule update --recursive
fi

install_polycube_morpheus

set +e
install_linux_perf_tool
popd
success_message
