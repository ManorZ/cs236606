#include <stdio.h>
#include <time.h>
#include <omp.h>
#define N_THREADS 1

#define N 1000000000

// double f( double x );

#pragma omp declare simd linear(x:1)
double f(double x){
  double ret;
  ret = 4.0 / (x*x + 1.0);
  return  ret; 
}

main()
{
    omp_set_num_threads(N_THREADS);
    double pi, x;
    clock_t start, stop;
    int i;

    const double h = (double)1.0/(double)N;
    double sum = 0.0;

    start = clock();
    #pragma omp parallel for simd private(x) reduction(+:sum) schedule(simd:static)
//     #pragma omp simd private(x) reduction(+:sum)
    for ( i=0; i<N ; i++ ){
        x = h*(i-0.5);
        sum += f(x);
    }
    stop = clock();

    // print value of pi to be sure multiplication is correct
    pi = h*sum;
    printf("    pi is approximately : %f \n", pi);
    // print elapsed time
    printf("Elapsed time = %lf seconds\n",((double)(stop - start)) / CLOCKS_PER_SEC);

}
