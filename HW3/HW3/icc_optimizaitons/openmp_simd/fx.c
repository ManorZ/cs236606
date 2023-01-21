#include <stdio.h>
#include <omp.h>

#pragma omp declare simd linear(x:1)
double f(double x){
  double ret;
  ret = 4.0 / (x*x + 1.0);
  return  ret; 
}
