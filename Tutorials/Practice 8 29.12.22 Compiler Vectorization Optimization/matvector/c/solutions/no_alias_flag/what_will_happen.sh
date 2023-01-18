
 source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
 icc -O2 -xCORE-AVX512 -qopt-zmm-usage=high multiply.c driver.c -o matvector -qopt-report=5 -fargument-noalias -diag-disable=10441
./matvector