#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

# # icc -O2 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi -diag-disable=10441 -prof-gen
# icc -O2 -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi -diag-disable=10441 -prof-gen
# echo "--------------------------------------------------"
# echo "Running O2 IPO Host with High ZMM Usage to Collect"
# echo "--------------------------------------------------"
# ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi
# # icc -O2 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi -diag-disable=10441 -prof-use
# icc -O2 -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi -diag-disable=10441 -prof-use
# echo "---------------------------------------"
# echo "Running O2 IPO Host with High ZMM Usage"
# echo "---------------------------------------"
# ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi
# mv ./bin_ipo_simd_pgo_opt/pi.optrpt ./bin_ipo_simd_pgo_opt/ipo_simd_host_o2_high_zmm_usage_pi.optrpt

# echo

# icc -O3 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi -diag-disable=10441 -prof-gen
icc -O3 -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi -diag-disable=10441 -prof-gen
echo "--------------------------------------------------" 
echo "Running O3 IPO Host with High ZMM Usage to Collect"
echo "--------------------------------------------------"
./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi
# icc -O3 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi -diag-disable=10441 -prof-use
icc -O3 -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi -diag-disable=10441 -prof-use
echo "---------------------------------------" 
echo "Running O3 IPO Host with High ZMM Usage"
echo "---------------------------------------"
./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_pgo_opt/pi.optrpt ./bin_ipo_simd_pgo_opt/ipo_simd_host_o3_high_zmm_usage_pi.optrpt

echo