#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
gcc -o bin/hist -O0 -fopenmp hist_sol.c random.c -lm
./bin/hist


