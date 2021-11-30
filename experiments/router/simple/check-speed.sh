#!/bin/bash

INTERVAL="1"  # update interval in seconds

function print_usage {
  echo
  echo "usage: $0 [network-interface] [execution-time (sec)]"
  echo "e.g. $0 eth0 30"
  echo "shows packets-per-second"
}

if [ -z "$1" ]; then
  print_usage
  exit
fi

if [ -z "$2" ]; then
  print_usage
  exit
fi 

MAX_TIME=$2
COUNTER=0

while true
do
  R1=$(cat /sys/class/net/"$1"/statistics/rx_packets)
  T1=$(cat /sys/class/net/"$1"/statistics/tx_packets)
  
  sleep $INTERVAL
  COUNTER=$((COUNTER + 1))

  R2=$(cat /sys/class/net/"$1"/statistics/rx_packets)
  T2=$(cat /sys/class/net/"$1"/statistics/tx_packets)
  TXPPS=$(($T2 - $T1))
  RXPPS=$(($R2 - $R1))
  echo "TX $1: $TXPPS pkts/s RX $1: $RXPPS pkts/s"

  if [ "$COUNTER" -ge "$MAX_TIME" ]; then
    break
  fi
done