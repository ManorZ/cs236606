#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

#compile with default compiler optimizations (feel free to add your own flags to achieve better performance!)
icc -O2 -fopenmp serial_heat.c -o ./bin/serial_heat.out -diag-disable=10441
./bin/serial_heat.out


