#!/bin/bash

########################
# Pktgen Configuration #
########################

# Place here the IP address of the server working as packet generator
export PKTGEN_SERVER_IP=<IP> 

# Place here the IP address of the server working as packet generator
export PKTGEN_SERVER_USER=<username> 

# Place here the full path to the folder where Morpheus repo is cloned on the Pktgen
# (e.g., PKTGEN_REMOTE_MORPHEUS_FOLDER="/home/morpheus/dev/Morpheus")
export PKTGEN_REMOTE_MORPHEUS_FOLDER="<folder>"

# Place here the id of the numa node where the NIC device is placed.
# If the server contains a single NUMA just put "0"
# E.g., NUMA_NODE_ID="0"
export NUMA_NODE_ID="<numa_id>"

# Put here the PCI dev id of the first interface of the NIC where we send traffic to the DUT
# E.g., PCI_ID_DEV1="0000:af:00.0"
export PCI_ID_DEV1="<pci-dev-id1>"

# Put here the PCI dev id of the second interface of the NIC where we receive traffic from the DUT
# E.g., PCI_ID_DEV1="0000:af:00.1"
export PCI_ID_DEV2="<pci-dev-id2>"

# MAC address of the first interface
# E.g., PKTGEN_MAC_IF1="00:11:22:33:44:55"
export PKTGEN_MAC_IF1="<mac-if1>"

# MAC address of the second interface
# E.g., PKTGEN_MAC_IF2="00:11:22:33:44:55"
export PKTGEN_MAC_IF2="<mac-if2>"

########################
# DUT Configuration    #
########################
# Place here the IP address of the server working as Device Under Test (DUT)
export DUT_SERVER_IP=<IP> 

# Place here the IP address of the server working as Device Under Test (DUT)
export DUT_SERVER_USER=<username> 

# Place here the full path to the folder where Morpheus repo is cloned on the DUT
# (e.g., DUT_REMOTE_MORPHEUS_FOLDER="/home/morpheus/dev/Morpheus")
export DUT_REMOTE_MORPHEUS_FOLDER="<folder>"

# Name of the first interface on the DUT connected to IF1 of the Pktgen
# E.g., IF1_NAME="ens4f0"
export IF1_NAME="<if1-name>"

# Name of the second interface on the DUT connected to IF2 of the Pktgen
# E.g., IF2_NAME="ens4f0"
export IF2_NAME="<if2-name>"

# MAC address of the first interface
# E.g., DUT_MAC_IF1="00:11:22:33:44:55"
export DUT_MAC_IF1="<mac-if1>"

# MAC address of the second interface
# E.g., DUT_MAC_IF2="00:11:22:33:44:55"
export DUT_MAC_IF2="<mac-if2>"