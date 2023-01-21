#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

#compile with default compiler optimizations + print detailed reports
icc -O2 -ipo -qopt-report=5  -qopt-report-phase=vec pi.c fx.c -o ./bin_default_opt_with_ipo/O2_pi -diag-disable=10441
# icc -O2 -ipo -qopt-report=5                         pi.c fx.c -o ./bin_default_opt_with_ipo/O2_pi -diag-disable=10441
./bin_default_opt_with_ipo/O2_pi


