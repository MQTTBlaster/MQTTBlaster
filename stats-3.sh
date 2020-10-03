#!/bin/sh

nw_intf="eno1"

## mqttprocess
# mosquitto -> mosquitto
# activemq -> java
# ?? -> beam.smp
mqttprocess="java"

# CPU Usage
echo -n `(grep 'cpu ' /proc/stat;sleep 0.25;grep 'cpu ' /proc/stat)|awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)","}'` 

# Mqtt cpu usage
echo -n `top -b -n 1 | grep $mqttprocess |grep -v grep| awk 'END{ if (NR==0 || $9 =="") print "0,"; else print $9 ","}'` 

# Disk Usage (read),(write)
echo -n `iostat | awk '/sda /{print $3","$4","}'` 

# Swap usage
echo -n `swapon -s | awk '/\/swapfile/{print $4","}'` 

# Memory usage
echo -n `awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}END{print 100-100*a/t","}' /proc/meminfo`     

# Network Rx
echo -n `(cat /sys/class/net/$nw_intf/statistics/rx_bytes; sleep 0.15; cat /sys/class/net/$nw_intf/statistics/rx_bytes) \
        | awk -v RS="" '{print ($2-$1)*5*8/1024/1024","}'`

# Network Tx
echo -n `(cat /sys/class/net/$nw_intf/statistics/tx_bytes; sleep 0.15; cat /sys/class/net/$nw_intf/statistics/tx_bytes) \
        | awk -v RS="" '{print ($2-$1)*5*8/1024/1024}'`
