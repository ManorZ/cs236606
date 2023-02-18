#!/bin/bash
#SBATCH -N 1 -p gpua100 --exclusive --time=5
module purge
module load gnu/9.1.0

gcc -O2 -fopenmp parallel_cpu_heat.c -o ./bin/parallel_cpu_heat -lm
./bin/parallel_cpu_heat

