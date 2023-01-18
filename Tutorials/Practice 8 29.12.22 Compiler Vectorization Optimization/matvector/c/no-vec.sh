 
 source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
 icc -O2 -xavx -no-vec multiply.c driver.c -o matvector -diag-disable=10441
./matvector