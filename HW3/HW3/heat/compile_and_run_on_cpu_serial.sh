#!/bin/bash
#SBATCH -N 1 -p gpua100 --exclusive --time=5
module purge
module load gnu/9.1.0

gcc -O2 -fopenmp serial_heat.c -o ./bin/serial_cpu_heat -lm
./bin/serial_cpu_heat

