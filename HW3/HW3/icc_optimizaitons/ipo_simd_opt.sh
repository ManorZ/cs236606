#!/bin/bash

source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1

#edit this compilation line to include ipo and simd extensions
icc -O2 -ipo -xCORE-AVX512                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx512_o2_pi -diag-disable=10441
echo "---------------------"
echo "Running O2 IPO AVX512"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx512_o2_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx512_o2_pi.optrpt

icc -O2 -ipo -xCORE-AVX512 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx512_o2_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O2 IPO AVX512 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx512_o2_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx512_o2_high_zmm_usage_pi.optrpt


icc -O2 -ipo -xSSE4.2                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_sse42_o2_pi -diag-disable=10441
echo "---------------------"
echo "Running O2 IPO SSE4.2"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_sse42_o2_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_sse42_o2_pi.optrpt

icc -O2 -ipo -xSSE4.2 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_sse42_o2_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O2 IPO SSE4.2 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_sse42_o2_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_sse42_o2_high_zmm_usage_pi.optrpt


icc -O2 -ipo -xAVX                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx_o2_pi -diag-disable=10441
echo "---------------------"
echo "Running O2 IPO AVX"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx_o2_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx_o2_pi.optrpt

icc -O2 -ipo -xAVX -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx_o2_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O2 IPO AVX with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx_o2_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx_o2_high_zmm_usage_pi.optrpt


icc -O2 -ipo -xCORE-AVX2                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx2_o2_pi -diag-disable=10441
echo "---------------------"
echo "Running O2 IPO AVX2"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx2_o2_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx2_o2_pi.optrpt

icc -O2 -ipo -xCORE-AVX2 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx2_o2_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O2 IPO AVX2 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx2_o2_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx2_o2_high_zmm_usage_pi.optrpt


icc -O2 -ipo -xHost                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_host_o2_pi -diag-disable=10441
echo "---------------------"
echo "Running O2 IPO Host"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_host_o2_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_host_o2_pi.optrpt

icc -O2 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_host_o2_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O2 IPO Host with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_host_o2_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_host_o2_high_zmm_usage_pi.optrpt


icc -O3 -ipo -xCORE-AVX512                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx512_o3_pi -diag-disable=10441
echo "---------------------"
echo "Running O3 IPO AVX512"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx512_o3_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx512_o3_pi.optrpt

icc -O3 -ipo -xCORE-AVX512 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx512_o3_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O3 IPO AVX512 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx512_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx512_o3_high_zmm_usage_pi.optrpt


icc -O3 -ipo -xSSE4.2                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_sse42_o3_pi -diag-disable=10441
echo "---------------------"
echo "Running O3 IPO SSE4.2"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_sse42_o3_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_sse42_o3_pi.optrpt

icc -O3 -ipo -xSSE4.2 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_sse42_o3_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O3 IPO SSE4.2 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_sse42_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_sse42_o3_high_zmm_usage_pi.optrpt


icc -O3 -ipo -xAVX                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx_o3_pi -diag-disable=10441
echo "---------------------"
echo "Running O3 IPO AVX"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx_o3_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx_o3_pi.optrpt

icc -O3 -ipo -xAVX -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx_o3_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O3 IPO AVX with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx_o3_high_zmm_usage_pi.optrpt


icc -O3 -ipo -xCORE-AVX2                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx2_o3_pi -diag-disable=10441
echo "---------------------"
echo "Running O3 IPO AVX2"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_avx2_o3_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx2_o3_pi.optrpt

icc -O3 -ipo -xCORE-AVX2 -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_avx2_o3_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O3 IPO AVX2 with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_avx2_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_avx2_o3_high_zmm_usage_pi.optrpt


icc -O3 -ipo -xHost                      -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_host_o3_pi -diag-disable=10441
echo "---------------------"
echo "Running O3 IPO Host"
echo "---------------------"
./bin_ipo_simd_opt/ipo_simd_host_o3_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_host_o3_pi.optrpt

icc -O3 -ipo -xHost -qopt-zmm-usage=high -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o ./bin_ipo_simd_opt/ipo_simd_host_o3_high_zmm_usage_pi -diag-disable=10441
echo "-----------------------------------------"
echo "Running O3 IPO Host with High ZMM Usage"
echo "-----------------------------------------"
./bin_ipo_simd_opt/ipo_simd_host_o3_high_zmm_usage_pi
mv ./bin_ipo_simd_opt/ipo_out.optrpt ./bin_ipo_simd_opt/ipo_simd_host_o3_high_zmm_usage_pi.optrpt