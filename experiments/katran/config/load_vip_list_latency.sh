#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
POLYCUBECTL="sudo polycubectl"

if [ -z "$1" ]; then
  echo "No argument supplied, first argument is file name with VIP list"
  exit 1
fi

FILE_NAME="$1"

NUM_SERVERS=100
if [ -z "$2" ]; then
  echo "Using default number of backend servers: ${NUM_SERVERS}"
else
  NUM_SERVERS=$2
fi

VIPS=()
while IFS= read -r line || [ -n "$line" ]; do
    # echo $line
    VIPS+=("$line")
done < $DIR/$FILE_NAME

i=0
for vip in "${VIPS[@]}"
do
  $POLYCUBECTL k1 vip add $vip
  IFS=' ' read -r -a vip_info <<< $vip
  port=$(( ${vip_info[1]} % 254 ))
  i=$((i+1))
  for n in $(seq 1 $NUM_SERVERS)
  do
    $POLYCUBECTL k1 vip $vip real add 10.$i.$port.$n weight=1
  done
done

$POLYCUBECTL k1 vip add 192.168.1.1 319 udp
$POLYCUBECTL k1 vip 192.168.1.1 319 udp real add 192.168.1.1 weight=1

$POLYCUBECTL k1 vip add 10.70.1.2 319 udp
$POLYCUBECTL k1 vip 10.70.1.2 319 udp real add 10.70.1.2 weight=1

$POLYCUBECTL k1 vip add 10.70.1.5 319 udp
$POLYCUBECTL k1 vip 10.70.1.5 319 udp real add 10.70.1.5 weight=1