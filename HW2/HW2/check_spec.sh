#!/bin/bash
echo "---------------"
echo "system - lscpu:"
echo "---------------"
lscpu
echo "----------------------------"
echo "cache per core - getconf -a:"
echo "----------------------------"
getconf -a | grep CACHE
# echo "------------------"
# echo "cat /proc/cpuinfo:"
# echo "------------------"
# cat /proc/cpuinfo
echo "------------------"
echo "cat /proc/meminfo:"
echo "------------------"
cat /proc/meminfo
echo "-------------------"
echo "numactl --hardware:"
echo "-------------------"
numactl --hardware