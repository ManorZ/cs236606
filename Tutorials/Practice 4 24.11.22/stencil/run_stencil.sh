#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
icx -o bin/stencil -O0 -fopenmp stencil_sol.c
./bin/stencil


