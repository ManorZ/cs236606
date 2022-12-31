#!/bin/bash
/bin/echo "##" $(whoami) is running HW1 Problem 1 - Calculate Mandelbrot area - parallel atomic
echo "########## Compiling your parallel atomic code"
source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

icx -o bin/mandel_parallel_atomic_O2 -fopenmp mandel_parallel_atomic.c
echo "########## Executing your parallel atomic -O2 code"
./bin/mandel_parallel_atomic_O2
echo "########## Done parallel atomic -O2"

icx -o bin/mandel_parallel_atomic_O0 -O0 -fopenmp mandel_parallel_atomic.c
echo "########## Executing your parallel atomic -O0 code"
./bin/mandel_parallel_atomic_O0
echo "########## Done parallel atomic -O0"

echo "##########"
echo "##########"
echo "##########"

icx -o bin/mandel_parallel_atomic_v1_O2 -fopenmp mandel_parallel_atomic_v1.c
echo "########## Executing your parallel atomic v1 -O2 code"
./bin/mandel_parallel_atomic_v1_O2
echo "########## Done parallel atomic v1 -O2"

icx -o bin/mandel_parallel_atomic_v1_O0 -O0 -fopenmp mandel_parallel_atomic_v1.c
echo "########## Executing your parallel atomic v1 -O0 code"
./bin/mandel_parallel_atomic_v1_O0
echo "########## Done parallel atomic v1 -O0"

echo "##########"
echo "##########"
echo "##########"

icx -o bin/mandel_parallel_atomic_v2_O2 -fopenmp mandel_parallel_atomic_v2.c
echo "########## Executing your parallel atomic v2 -O2 code"
./bin/mandel_parallel_atomic_v2_O2
echo "########## Done parallel atomic v2 -O2"

icx -o bin/mandel_parallel_atomic_v2_O0 -O0 -fopenmp mandel_parallel_atomic_v2.c
echo "########## Executing your parallel atomic v2 -O0 code"
./bin/mandel_parallel_atomic_v2_O0
echo "########## Done parallel atomic v2 -O0"