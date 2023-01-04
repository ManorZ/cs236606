#include <omp.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
int main(const int argc, const char** argv)
{
    if (argc > 1) {
        int n_threads = atoi(argv[1]);
        omp_set_num_threads(n_threads);
    }
    long int VectorSize = 2e9;
//     long int VectorSize = 2e3;
    double* a = (double*)malloc(VectorSize*sizeof(double));
    double* b = (double*)malloc(VectorSize*sizeof(double));
    double* c = (double*)malloc(VectorSize*sizeof(double));
    double d = 3.543;
        
    //Step 1.a Initialization by initial thread only 
   for (int j = 0; j < VectorSize; j++) { 
       a[j] = 1.1-j;
       b[j] = 2.2+j;
       c[j] = 3.3*j;
    }

    //Step 1.b Initialization by all threads (first touch)
    /*#pragma omp parallel for schedule(static)
    for (int j = 0; j < VectorSize; j++) { 
       a[j] = 1.1-j;
       b[j] = 2.2+j;
       c[j] = 3.3*j;
    }*/

    double start_time = omp_get_wtime();
   //Step 2 Compute
    #pragma omp parallel
    {
    #pragma omp master
    printf("Number of threads %d ", omp_get_num_threads());   
    #pragma omp for schedule(static)
    for (int j = 0; j < VectorSize; j++) {
       a[j] = b[j] + d * c[j];
    }
    }
    
     printf("Master thread init ");
     printf("Execution time: %f seconds ", omp_get_wtime()-start_time);
     printf("OpenMP threads binding policy is %d \n", omp_get_proc_bind()); 
     // note that OpenMP Binding policy will be 3 if "close"
     // note that OpenMP Binding policy will be 4 if "spread"
}