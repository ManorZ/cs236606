
 source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
 icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high rabs.c square_charge.c trap.c twod.c -o sq -qopt-report=5 -ipo -qopt-report-phase=ipo -diag-disable=10441
 #-ipo -qopt-report-phase=ipo
 #-qopt-report=5 
 #-fp-model precise
./sq