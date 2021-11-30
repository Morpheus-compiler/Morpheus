#! /bin/bash

sudo polycubectl pcn-iptables set interactive=false

set -x
sudo polycubectl pcn-iptables chain FORWARD set default=drop
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.179.176/28 l4proto=UDP sport=53:53 dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.179.176/28 l4proto=UDP sport=161:161 dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.144/28 l4proto=UDP sport=53:53 dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.144/28 l4proto=UDP sport=53:53 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.112/28 l4proto=UDP sport=123:123 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.112/28 l4proto=UDP sport=161:161 dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.112/28 l4proto=UDP sport=88:88 dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.132.144/28 l4proto=UDP sport=53:53 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=161:161 dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=53:53 dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=750:750 dport=179:179 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=67:67 dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=7648:7648 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=123:123 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.128/28 l4proto=UDP sport=88:88 dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.96/28 dst=208.95.48.208/28 l4proto=UDP sport=88:88 dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.96/28 dst=208.95.48.208/28 l4proto=UDP sport=24032:24032 dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.124 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=147.85.2.47 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=23.158.81.23 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=123:123 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=162:162 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=69:69 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=53:53 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=88:88 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=161:161 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=750:750 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=2055:2055 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=24032:24032 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=147.85.2.47 dst=208.95.48.246 l4proto=UDP sport=1024:65535 dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.120.68.216 dst=209.120.64.245 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=23.158.81.23 dst=23.158.84.203 l4proto=UDP sport=1024:65535 dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.232/29 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.96/28 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.192/27 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.134.0/23 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=210.0.72.0/21 dst=180.204.131.232 l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=210.0.72.0/21 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.120.68.19 dst=180.204.131.235 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=23.158.81.23 dst=23.158.84.184 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=183.17.88.0/21 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=183.17.88.0/21 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.128/26 dst=209.181.176.0/21 l4proto=TCP dport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP sport=161:161 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP sport=123:123 dport=873:873 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=53:53 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP sport=161:161 dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.152/30 dst=180.204.131.235 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.152/30 dst=180.204.131.235 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.152/30 dst=180.204.131.235 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.152/30 dst=180.204.131.235 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=UDP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=180.204.128.0/21 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=183.17.88.0/21 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=183.17.88.0/21 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.192/26 dst=183.17.88.0/21 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.132.136/30 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.236/30 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=210.0.79.80 dst=209.181.179.180/30 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.152/30 dst=180.204.131.235 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.224/30 dst=180.204.131.235 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=208.95.48.220/30 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=183.17.93.128/30 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.131.236/30 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.132.128/28 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.124 dst=208.95.48.208/28 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.117 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.159 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.159 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.122 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.121 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.96/28 dst=208.95.48.212 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.240/28 dst=209.181.179.179 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.176.0.0/12 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=180.204.132.128/28 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.124 dst=208.95.48.208/28 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=186.114.73.117 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.159 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=209.181.146.157 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=208.95.48.218 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.0.0.0/8 dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=186.114.72.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=209.181.183.230 dst=209.181.176.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.158 dst=209.181.144.0/21 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=183.17.93.134 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.128/28 dst=180.204.131.235 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.50.251 l4proto=UDP sport=750:750 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.54.109 l4proto=UDP sport=750:750 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=179:179 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=2401:2401 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=2055:2055 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=143:143 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=179:179 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=871:871 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=24032:24032 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=179:179 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=143:143 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=162:162 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=5998:5998 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=873:873 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=162:162 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.112 l4proto=TCP dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.112 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.117 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.134.66 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP sport=1024:65535 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP sport=1024:65535 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=1024:65535 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=1024:65535 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=UDP sport=1024:65535 dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.134.6 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.170 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.1.125.144 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.1.124.132 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=147.85.3.152 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.50.251 l4proto=UDP sport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.50.251 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.54.109 l4proto=UDP sport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.54.109 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=153.90.25.25 l4proto=UDP sport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=153.90.25.25 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP sport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=24032:24032 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=UDP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=24032:24032 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=871:871 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=2055:2055 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=UDP dport=143:143 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=873:873 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=2401:2401 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=5998:5998 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=24032:24032 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=162:162 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=2055:2055 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=UDP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=UDP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.152 l4proto=UDP dport=5998:5998 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=7648:7648 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=UDP dport=2401:2401 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.128/27 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.96/27 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.134.32/27 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.134.96/27 l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.235 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.107 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=147.85.3.152 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.50.251 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=153.90.25.25 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.131.232 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.140 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.158 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=180.204.132.125 l4proto=UDP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.120/30 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.120/30 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.112/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.120/30 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.120/30 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.144/29 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.160/29 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.128/27 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.64/27 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.1.125.160/27 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.145.252.0/26 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=146.12.50.251 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=180.204.132.160/27 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=879:879 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=7649:7649 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=119:119 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=2401:2401 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=69:69 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=8080:8080 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=5998:5998 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=23:23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.144.0.0/12 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.0.0.0/12 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.0.0.0/8 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=33434:33600 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=1024:65535 dport=33434:33600 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=149.0.0.0/8 l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=GRE action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT

set +x
sudo polycubectl pcn-iptables chain FORWARD apply-rules
sudo polycubectl pcn-iptables set interactive=false
sudo polycubectl pcn-iptables set conntrack=off
