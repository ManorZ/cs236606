#!/bin/bash
source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
icx n-body_parallel_v2.c -fopenmp -lm -O0 -o ./bin/n-body_parallel_v2  
./bin/n-body_parallel_v2

