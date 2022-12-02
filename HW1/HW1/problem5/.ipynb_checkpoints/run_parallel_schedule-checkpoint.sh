#!/bin/bash
/bin/echo "##" $(whoami) is running HW1 Problem 5 - Prime Numbers 
echo "########## Compiling the parallel code"
source /opt/intel/inteloneapi/setvars.sh > /dev/null 2>&1
# icx -o bin/prime_parallel_default_schedule_01t -fopenmp prime_parallel_default_schedule_01t.c
# icx -o bin/prime_parallel_default_schedule_02t -fopenmp prime_parallel_default_schedule_02t.c
# icx -o bin/prime_parallel_default_schedule_04t -fopenmp prime_parallel_default_schedule_04t.c
# icx -o bin/prime_parallel_default_schedule_08t -fopenmp prime_parallel_default_schedule_08t.c
# icx -o bin/prime_parallel_default_schedule_16t -fopenmp prime_parallel_default_schedule_16t.c
# icx -o bin/prime_parallel_default_schedule_24t -fopenmp prime_parallel_default_schedule_24t.c


# icx -o bin/prime_parallel_static_schedule_01t -fopenmp prime_parallel_static_schedule_01t.c
# icx -o bin/prime_parallel_static_schedule_02t -fopenmp prime_parallel_static_schedule_02t.c
# icx -o bin/prime_parallel_static_schedule_04t -fopenmp prime_parallel_static_schedule_04t.c
# icx -o bin/prime_parallel_static_schedule_08t -fopenmp prime_parallel_static_schedule_08t.c
# icx -o bin/prime_parallel_static_schedule_16t -fopenmp prime_parallel_static_schedule_16t.c
# icx -o bin/prime_parallel_static_schedule_24t -fopenmp prime_parallel_static_schedule_24t.c


# icx -o bin/prime_parallel_static4_schedule_01t -fopenmp prime_parallel_static4_schedule_01t.c
# icx -o bin/prime_parallel_static4_schedule_02t -fopenmp prime_parallel_static4_schedule_02t.c
# icx -o bin/prime_parallel_static4_schedule_04t -fopenmp prime_parallel_static4_schedule_04t.c
# icx -o bin/prime_parallel_static4_schedule_08t -fopenmp prime_parallel_static4_schedule_08t.c
# icx -o bin/prime_parallel_static4_schedule_16t -fopenmp prime_parallel_static4_schedule_16t.c
# icx -o bin/prime_parallel_static4_schedule_24t -fopenmp prime_parallel_static4_schedule_24t.c


# icx -o bin/prime_parallel_static8_schedule_01t -fopenmp prime_parallel_static8_schedule_01t.c
# icx -o bin/prime_parallel_static8_schedule_02t -fopenmp prime_parallel_static8_schedule_02t.c
# icx -o bin/prime_parallel_static8_schedule_04t -fopenmp prime_parallel_static8_schedule_04t.c
# icx -o bin/prime_parallel_static8_schedule_08t -fopenmp prime_parallel_static8_schedule_08t.c
# icx -o bin/prime_parallel_static8_schedule_16t -fopenmp prime_parallel_static8_schedule_16t.c
# icx -o bin/prime_parallel_static8_schedule_24t -fopenmp prime_parallel_static8_schedule_24t.c


# icx -o bin/prime_parallel_dyna8_schedule_01t -fopenmp prime_parallel_dyna8_schedule_01t.c
# icx -o bin/prime_parallel_dyna8_schedule_02t -fopenmp prime_parallel_dyna8_schedule_02t.c
# icx -o bin/prime_parallel_dyna8_schedule_04t -fopenmp prime_parallel_dyna8_schedule_04t.c
# icx -o bin/prime_parallel_dyna8_schedule_08t -fopenmp prime_parallel_dyna8_schedule_08t.c
# icx -o bin/prime_parallel_dyna8_schedule_16t -fopenmp prime_parallel_dyna8_schedule_16t.c
# icx -o bin/prime_parallel_dyna8_schedule_24t -fopenmp prime_parallel_dyna8_schedule_24t.c


# icx -o bin/prime_parallel_guided_schedule_01t -fopenmp prime_parallel_guided_schedule_01t.c
# icx -o bin/prime_parallel_guided_schedule_02t -fopenmp prime_parallel_guided_schedule_02t.c
# icx -o bin/prime_parallel_guided_schedule_04t -fopenmp prime_parallel_guided_schedule_04t.c
# icx -o bin/prime_parallel_guided_schedule_08t -fopenmp prime_parallel_guided_schedule_08t.c
# icx -o bin/prime_parallel_guided_schedule_16t -fopenmp prime_parallel_guided_schedule_16t.c
# icx -o bin/prime_parallel_guided_schedule_24t -fopenmp prime_parallel_guided_schedule_24t.c

icx -o bin/prime_parallel_guided8_schedule_01t -fopenmp prime_parallel_guided8_schedule_01t.c
icx -o bin/prime_parallel_guided8_schedule_02t -fopenmp prime_parallel_guided8_schedule_02t.c
icx -o bin/prime_parallel_guided8_schedule_04t -fopenmp prime_parallel_guided8_schedule_04t.c
icx -o bin/prime_parallel_guided8_schedule_08t -fopenmp prime_parallel_guided8_schedule_08t.c
icx -o bin/prime_parallel_guided8_schedule_16t -fopenmp prime_parallel_guided8_schedule_16t.c
icx -o bin/prime_parallel_guided8_schedule_24t -fopenmp prime_parallel_guided8_schedule_24t.c


echo "########## Executing the parallel code"
# ./bin/prime_parallel_default_schedule_01t
# ./bin/prime_parallel_default_schedule_02t
# ./bin/prime_parallel_default_schedule_04t
# ./bin/prime_parallel_default_schedule_08t
# ./bin/prime_parallel_default_schedule_16t
# ./bin/prime_parallel_default_schedule_24t


# ./bin/prime_parallel_static_schedule_01t
# ./bin/prime_parallel_static_schedule_02t
# ./bin/prime_parallel_static_schedule_04t
# ./bin/prime_parallel_static_schedule_08t
# ./bin/prime_parallel_static_schedule_16t
# ./bin/prime_parallel_static_schedule_24t


# ./bin/prime_parallel_static4_schedule_01t
# ./bin/prime_parallel_static4_schedule_02t
# ./bin/prime_parallel_static4_schedule_04t
# ./bin/prime_parallel_static4_schedule_08t
# ./bin/prime_parallel_static4_schedule_16t
# ./bin/prime_parallel_static4_schedule_24t

# ./bin/prime_parallel_static8_schedule_01t
# ./bin/prime_parallel_static8_schedule_02t
# ./bin/prime_parallel_static8_schedule_04t
# ./bin/prime_parallel_static8_schedule_08t
# ./bin/prime_parallel_static8_schedule_16t
# ./bin/prime_parallel_static8_schedule_24t

# ./bin/prime_parallel_dyna8_schedule_01t
# ./bin/prime_parallel_dyna8_schedule_02t
# ./bin/prime_parallel_dyna8_schedule_04t
# ./bin/prime_parallel_dyna8_schedule_08t
# ./bin/prime_parallel_dyna8_schedule_16t
# ./bin/prime_parallel_dyna8_schedule_24t

# ./bin/prime_parallel_guided_schedule_01t
# ./bin/prime_parallel_guided_schedule_02t
# ./bin/prime_parallel_guided_schedule_04t
# ./bin/prime_parallel_guided_schedule_08t
# ./bin/prime_parallel_guided_schedule_16t
# ./bin/prime_parallel_guided_schedule_24t

./bin/prime_parallel_guided8_schedule_01t
./bin/prime_parallel_guided8_schedule_02t
./bin/prime_parallel_guided8_schedule_04t
./bin/prime_parallel_guided8_schedule_08t
./bin/prime_parallel_guided8_schedule_16t
./bin/prime_parallel_guided8_schedule_24t
echo "########## Done parallel"

