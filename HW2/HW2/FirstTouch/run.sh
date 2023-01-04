#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
icx firstTouch.c -fopenmp -O0 -o bin/firstTouch
icx noFirstTouch.c -fopenmp -O0 -o bin/noFirstTouch

export OMP_PROC_BIND="close"
for i in 1 2 4 6 8 10 12 14 16 18 20 22 24
do
#    export OMP_NUM_THREDS=$i
#    echo "Running ${OMP_PROC_BIND} binding with ${OMP_NUM_THREDS} threads master thread initialization"
    ./bin/firstTouch $i
    ./bin/noFirstTouch $i
done

export OMP_PROC_BIND="spread"
for i in 1 2 4 6 8 10 12 14 16 18 20 22 24
do
#    export OMP_NUM_THREDS=$i
#    echo "Running ${OMP_PROC_BIND} binding with ${OMP_NUM_THREDS} threads first touch initialization"
    ./bin/firstTouch $i
    ./bin/noFirstTouch $i
done

