#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

# icc -O3 -fopenmp -xCORE-AVX512 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_openmp_simd/openmp_simd_pi -diag-disable=10441
# icc -O3 -fopenmp                                    -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_openmp_simd/openmp_simd_pi -diag-disable=10441
# icc -O3 -fopenmp -xAVX         -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_openmp_simd/openmp_simd_pi -diag-disable=10441
icc -O3 -fopenmp -xCORE-AVX512 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c      -o ./bin_openmp_simd/openmp_simd_pi -diag-disable=10441

./bin_openmp_simd/openmp_simd_pi


