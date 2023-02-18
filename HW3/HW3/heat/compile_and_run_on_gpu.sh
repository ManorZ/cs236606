#!/bin/bash
#SBATCH -N 1 -p gpua100 --exclusive --time=5
module purge
module load gnu/9.1.0

gcc -O2 -fopenmp parallel_gpu_heat.c -o ./bin/parallel_gpu_heat -lm
./bin/parallel_gpu_heat

