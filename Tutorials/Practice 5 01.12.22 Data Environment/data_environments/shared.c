
#include <omp.h>
#include <stdio.h>

extern void initialize(int*, int*, int*);

int main ()  
{
   int A, B, C;
  
   initialize(&A, &B, &C);
   
   //remember the value of A before the parallel region
   printf("A before = %d\n", A);
  
   #pragma omp parallel default(none) shared(A,B,C)
   { 
      int A = omp_get_thread_num();
      #pragma omp critical
         C = B + A;
   }
  
   // A in the parallel region goes out of scope, we revert
   // to the original variable for A
   printf("A after = %d and C = %d\n", A, C);
}