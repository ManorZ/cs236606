#!/bin/bash
source /opt/intel/inteloneapi/setvars.sh

#vtune
# type=hotspots
#type=memory-consumption
#type=uarch-exploration
#type=memory-access
type=threading
#type=hpc-performance
#type=system-overview
#type=graphics-rendering
#type=io
#type=fpga-interaction
#type=gpu-offload
# type=gpu-hotspots
#type=throttling
#type=platform-profiler
#type=cpugpu-concurrency
#type=tsx-exploration
#type=tsx-hotspots
#type=sgx-hotspots

rm -r vtune_data

echo "VTune Collect $type"
# vtune -collect $type -result-dir vtune_data $(pwd)/bin/prime_parallel_default_schedule_04t
# vtune -collect $type -result-dir vtune_data $(pwd)/bin/prime_parallel_default_schedule_24t
# vtune -collect $type -result-dir vtune_data $(pwd)/bin/prime_parallel_guided_schedule_04t
vtune -collect $type -result-dir vtune_data $(pwd)/bin/prime_parallel_guided_schedule_24t

echo "VTune Summary Report"
# vtune -report summary -result-dir vtune_data -format html -report-output $(pwd)/prime_parallel_default_schedule_04t_${type}_summary.html
# vtune -report summary -result-dir vtune_data -format html -report-output $(pwd)/prime_parallel_default_schedule_24t_${type}_summary.html
# vtune -report summary -result-dir vtune_data -format html -report-output $(pwd)/prime_parallel_guided_schedule_04t_${type}_summary.html
vtune -report summary -result-dir vtune_data -format html -report-output $(pwd)/prime_parallel_guided_schedule_24t_${type}_summary.html
