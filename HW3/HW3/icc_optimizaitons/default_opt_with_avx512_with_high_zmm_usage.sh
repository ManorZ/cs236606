#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

#compile with default compiler optimizations + print detailed reports
icc -O2 -ipo -xCORE-AVX512 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_default_opt_with_avx512_with_high_zmm_usage/O2_pi -diag-disable=10441
# icc -O2 -ipo -xCORE-AVX512                      -qopt-report=5                        pi.c fx.c -o ./bin_default_opt_with_avx512_with_high_zmm_usage/O2_pi -diag-disable=10441
./bin_default_opt_with_avx512_with_high_zmm_usage/O2_pi


