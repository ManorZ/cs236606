/*
**  PROGRAM: Mandelbrot area
**
**  PURPOSE: Program to compute the area of a  Mandelbrot set.
**           Correct answer should be around 1.510659.
**           WARNING: this program may contain errors
**
**  USAGE:   Program runs without input ... just run the executable
**            
**  HISTORY: Written:  (Mark Bull, August 2011).
**           Changed "comples" to "d_comples" to avoid collsion with 
**           math.h complex type (Tim Mattson, September 2011)
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

# define NPOINTS 5000
# define MAXITER 5000
#define NELEMS(x)  (sizeof(x) / sizeof((x)[0]))
# define PAD 16

void testpoint(int);

struct d_complex {
   double r;
   double i;
};

struct d_complex c;
int numoutside = 0;
int numoutside_per_thread[24][PAD] = {0};

int main() {
    
   printf("sizeof(numoutside_per_thread[0][0]) = %lu\n", sizeof(numoutside_per_thread[0][0]));
    
   int threads[6] = {1,2,4,8,16,24};  
   int i, j;
   double area, error, eps = 1.0e-5;
   double start_time, run_time;

   // Test varying number of threads: 1,2,4,8,16 and 24 threads
   for (int k=0; k< NELEMS(threads); k++) {
        numoutside = 0;
        int num_of_threads = threads[k];
       
        for (int kk = 0 ; kk < num_of_threads ; kk++)
            numoutside_per_thread[kk][0] = 0;
        
        omp_set_num_threads(num_of_threads);
        start_time = omp_get_wtime();
       
       // Loop over grid of points in the complex plane which contains 
       // the Mandelbrot set, test each point to see whether it is 
       // inside or outside the set
       #pragma omp parallel for collapse(2) private(i,j,c)
       for (i = 0; i < NPOINTS; i++) {
          for (j = 0; j < NPOINTS; j++) {
             c.r = -2.0 + 2.5 * (double)(i) / (double)(NPOINTS) + eps;
             c.i = 1.125 * (double)(j) / (double)(NPOINTS) + eps;
             int thread_id = omp_get_thread_num();
             testpoint(thread_id);
          }
       }
       
       for (int kk = 0 ; kk < num_of_threads ; kk++)
            numoutside += numoutside_per_thread[kk][0];
       
       run_time = omp_get_wtime() - start_time;
       // Calculate area of set and error estimate and output the results
       area = 2.0 * 2.5 * 1.125 * (double)(NPOINTS * NPOINTS - numoutside) 
             / (double)(NPOINTS * NPOINTS);
       error = area / (double)NPOINTS;
       printf("Area of Mandlebrot set = %12.8f +/- %12.8f\n",area,error);
       printf("Parallel-16-Padding implementation - time: %f seconds, with %d threads\n\n",run_time, num_of_threads);
   }
   printf("(Correct answer should be around 1.506)\n");
}

void testpoint(int thread_id) {

   // Does the iteration z=z*z+c, until |z| > 2 when point is known to 
   // be outside set. If loop count reaches MAXITER, point is considered 
   // to be inside the set.

   struct d_complex z;
   int iter;
   double temp;

   z = c;
   for (iter = 0; iter < MAXITER; iter++) {
      temp = (z.r * z.r) - (z.i * z.i) + c.r;
      z.i = z.r * z.i * 2 + c.i;
      z.r = temp;
      if ((z.r * z.r + z.i * z.i) > 4.0) {
         numoutside_per_thread[thread_id][0]++;
         break;
      }
   }
}


