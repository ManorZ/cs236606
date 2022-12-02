#!/bin/bash
/bin/echo "##" "$(whoami) is running HW1 Problem 1 - Calculate Mandelbrot area - parallel padding(PAD=08)"
echo "########## Compiling your parallel padding code"
source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
# icx -o bin/mandel_parallel_padding_08pad -fopenmp mandel_parallel_padding_08pad.c
icx -o bin/mandel_parallel_padding_08pad -O0 -fopenmp mandel_parallel_padding_08pad.c
echo "########## Executing your parallel padding code"
./bin/mandel_parallel_padding_08pad
echo "########## Done parallel padding"
