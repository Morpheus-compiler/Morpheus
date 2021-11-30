#! /bin/bash

sudo polycubectl pcn-iptables set interactive=false
sudo polycubectl pcn-iptables chain FORWARD set default=drop

sudo polycubectl pcn-iptables chain FORWARD append src=186.142.49.218 dst=19.207.218.138 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=186.142.49.218 dst=19.207.218.130 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=186.142.49.218 dst=30.207.19.169 l4proto=UDP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=186.142.49.218 dst=19.207.218.138 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.183 dst=19.207.218.130 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.153 dst=19.207.218.130 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.197 dst=19.207.218.130 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=UDP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=TCP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.222.0/24 dst=19.207.218.130 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.180 dst=19.207.216.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.180 dst=19.207.216.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.183 dst=19.207.216.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.153 dst=19.23.232.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.153 dst=19.23.232.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.197 dst=30.207.16.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=186.142.49.218 dst=186.142.48.0/21 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=123:123 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=53:53 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.239 l4proto=UDP sport=123:123 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=UDP sport=123:123 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.164 l4proto=TCP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.185 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.185 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.185 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.151 l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.146 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.221.127 l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.221.127 l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.221.127 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.221.127 l4proto=TCP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=186.142.54.74 l4proto=TCP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=186.142.54.71 l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP sport=1024:65535 dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP sport=1024:65535 dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP sport=1024:65535 dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP sport=1024:65535 dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP sport=1024:65535 dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP sport=1024:65535 dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP sport=1024:65535 dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.230 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.230 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.230 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.225 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.225 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.239 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.154 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.154 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.154 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.157 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.157 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.157 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.157 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.209 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.209 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.209 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.215 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.215 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.215 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=UDP sport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.126.157.222 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.126.157.222 l4proto=UDP sport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=104.170.13.106 l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=104.170.13.106 l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=104.170.13.106 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=104.170.13.106 l4proto=UDP sport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=104.170.11.97 l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=161:161 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=UDP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=137:137 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.138 l4proto=UDP dport=6667:6667 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=UDP dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=7326:7326 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=9000:9000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=67:67 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=110:110 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=7000:7000 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=9090:9090 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=UDP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=5999:5999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.164 l4proto=UDP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.163 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.222.163 l4proto=UDP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.221.127 l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.23.236.79 l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=186.142.54.74 l4proto=UDP dport=9001:9001 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=186.142.54.74 l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.130 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.142 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.158 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append dst=19.207.218.152 l4proto=TCP sport=1024:65535 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.230 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.239 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.23.232.157 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.210 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.215 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.215 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.153 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.144 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.192/27 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.192/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.224/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=17.165.215.224/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.160/27 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.192/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.207.22.160/27 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.223.243 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=138:138 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=9002:9002 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=37:37 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=514:514 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=79:79 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=749:749 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=113:113 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=750:750 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=21:21 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=544:544 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=80:80 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=2105:2105 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=22:22 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=139:139 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=13:13 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=464:464 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=88:88 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=9091:9091 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=754:754 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=1999:1999 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP dport=443:443 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP dport=25:25 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=53:53 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=7007:7007 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=123:123 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.207.220.0/23 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.192.0.0/12 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.192.0.0/12 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.192.0.0/12 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=30.192.0.0/12 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.0.0.0/8 l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.0.0.0/8 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=UDP sport=33434:33600 dport=1024:65535 action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append src=19.0.0.0/8 l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=TCP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append l4proto=ICMP action=ACCEPT
sudo polycubectl pcn-iptables chain FORWARD append action=ACCEPT

sudo polycubectl pcn-iptables chain FORWARD apply-rules
sudo polycubectl pcn-iptables set interactive=false
sudo polycubectl pcn-iptables set conntrack=off
