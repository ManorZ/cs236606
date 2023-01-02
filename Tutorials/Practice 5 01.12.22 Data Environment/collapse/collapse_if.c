
#include <omp.h>

// apply a function (*MFUNC) to each element of an N by M array

void Apply(int N, int M, float* A, void(*MFUNC)(int, int, float*))
{ 
   #pragma omp parallel for num_threads(4) collapse(2) if(N*M>100)
      for (int i = 0; i < N; i++)
         for (int j = 0; j < M; j++)
            MFUNC(i, j, (A+i*M+j));
}