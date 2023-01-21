#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

#compile with default compiler optimizations (feel free to add your own flags to achieve better performance!)
# icc -O2 -fopenmp parallel_cpu_heat.c -o ./bin/heat_cpu.out -diag-disable=10441
icc -O3 -fopenmp parallel_cpu_heat.c -o ./bin/heat_cpu.out -diag-disable=10441
./bin/heat_cpu.out


