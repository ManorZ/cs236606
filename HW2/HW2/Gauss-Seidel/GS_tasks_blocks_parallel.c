#include <omp.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define NTHREADS 12

void printMatrix(double **a,int n);//helper to print matrix

void gauss_seidel_serial(int tsteps, int size, double **p) {
   for (int t = 0; t < tsteps; ++t) {
      for (int i = 1; i < size-1; ++i) {
         for (int j = 1; j < size-1; ++j) {
                          p[i][j] = 0.2*p[i][j-1] + 
                                    0.3*p[i][j+1] +
                                    0.1*p[i-1][j] + 
                                    0.4*p[i+1][j];
         }
      }
   }
}

void gauss_seidel(int tsteps, int size, int TS, double **p) {
    for(int t=0; t< tsteps; ++t)
        for (int ii = 1; ii+TS < size; ii+=TS) 
            for (int jj = 1; jj+TS < size; jj+=TS) 
                //insert all the following work (on TSxTS cells) to a single task
                // depend on         the row above (p[ii-1][jj:jj+TS-1]),     the col on the left (p[ii:ii+TS-1][jj-1]) and the corner cell upper-left (p[ii-1][jj-1])
                // put dependence on the row below (p[ii+TS][jj:jj+TS-1]) and the col on the right (p[ii:ii+TS-1][jj+TS])
                #pragma omp task depend(in:p[ii-1][jj:jj+TS],p[ii:ii+TS][jj-1],p[ii-1][jj-1]) depend(out:p[ii+TS][jj:jj+TS],p[ii:ii+TS][jj+TS])
                {
                    for (int i = ii; i < ii+TS; ++i)
                        for (int j = jj; j < jj+TS; ++j)
                            p[i][j] =   0.2*p[i][j-1] + 
                                        0.3*p[i][j+1] +
                                        0.1*p[i-1][j] + 
                                        0.4*p[i+1][j];
                }
}


int main(){ 
    
  double **p;
//   int size = 6002;
  int size = 52;
//   int tsteps = 100;
  int tsteps = 3;
  int i,j;
  double start;
//   int TS = 500;
  int TS = 10;
  omp_set_num_threads(NTHREADS);
  p=(double **)malloc(sizeof(double *)*size);  
  
  for(i=0;i<size;i++){
    p[i]=(double *)malloc(sizeof(double)*size); 
   }
 
  for(i=0;i<size;i++){
    for(j=0;j<size;j++){
      p[i][j]=(0.05*i+0.04*j);
    }
  }
     
   #pragma omp parallel
   {
     #pragma omp master
       start = omp_get_wtime();
     # pragma omp single
       gauss_seidel(tsteps, size, TS, p);
     #pragma omp master
       printf("Tasks Blocks Order %d Block Size %d %d Steps Execution time: %f sec, with %d threads \n", size, TS, tsteps, omp_get_wtime()-start, NTHREADS);
   }
   
   double sum=0;
   for(i=0;i<size;i++){
     for(j=0;j<size;j++){
        sum += p[i][j];
     }
   }
   
    printf("sum = %f \n", sum); 
   if(fabs(sum - 9825298683.981915) < 0.0001)
       printf("correct answer\n");
    else
       printf("ERROR = wrong answer\n");
    
    printf("\n\n\n");
    printMatrix(p, size);
    printf("\n\n\n");
    
    /* Running Serial as a referecne */
    
    double **ser_p=(double **)malloc(sizeof(double *)*size);
    for(i=0;i<size;i++){
      ser_p[i]=(double *)malloc(sizeof(double)*size); 
    }
    
    /* Re-Initializing array p*/
    
    for(i=0;i<size;i++){
      for(j=0;j<size;j++){
        ser_p[i][j]=(0.05*i+0.04*j);
      }
    }
    
    gauss_seidel_serial(tsteps, size, ser_p);
    
    double ser_sum=0;
    for(i=0;i<size;i++){
      for(j=0;j<size;j++){
        ser_sum += ser_p[i][j];
      }
    }
    
    printf("ser_sum = %f \n", ser_sum); 
   if(fabs(ser_sum - 9825298683.981915) < 0.0001)
       printf("serial: correct answer\n");
    else
       printf("serial: ERROR = wrong answer\n");
    
    double diff_sum = fabs(sum-ser_sum);
    printf("diff_sum = %f \n", diff_sum); 
    
    printf("\n\n\n");
    printMatrix(ser_p, size);
    printf("\n\n\n");
    
    double **diff_p=(double **)malloc(sizeof(double *)*size);
    for(i=0;i<size;i++){
      diff_p[i]=(double *)malloc(sizeof(double)*size); 
    }
    for(i=0;i<size;i++){
      for(j=0;j<size;j++){
        diff_p[i][j]=fabs(p[i][j]-ser_p[i][j]);
      }
    }
    
    printf("\n\n\n");
    printMatrix(diff_p, size);
    printf("\n\n\n");
    
   
   //free memory
   for(i=0;i<size;i++){
     free(p[i]);
   }
   free(p);
   
   for(i=0;i<size;i++){
     free(ser_p[i]);
   }
   free(ser_p);
    
   return 0;
}

void printMatrix(double **mat,int n) {
    int i,j;
    for(i=0;i<n;i++) {
        for(j=0;j<n;j++) {
            printf("%.4f ",mat[i][j]);
        }
        printf("\n");
    }
    printf("------------------------------------------------\n");
}