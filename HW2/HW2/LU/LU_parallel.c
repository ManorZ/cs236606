#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>
#include<math.h>
#include "omp.h"

#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))

void printMatrix(double **a,int n);//helper to print matrix


void *memset(void *str,int c, size_t t);//too many warnings...so you know.
void *memcpy(void *str1,const void *str2,size_t n);

int main(int argc, char **argv) {
    int i,j,k,t;
    int n;
    int flag;
    double l1,u1;
    double **a;
    double **b;
    double **c;
    double start;
    double end;
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};

    n=2000;
 
    a=(double **)malloc(sizeof(double *)*n);  
    b=(double **)malloc(sizeof(double *)*n);
    c=(double **)malloc(sizeof(double *)*n);
    
    for ( int x=0; x<NELEMS(omp_threads); x++ ) {
        int num_threads = omp_threads[x];
        omp_set_num_threads(num_threads);
  
        printf(" Running %d threads ...", num_threads);
        
        /* Initialize matrices */
        
        for(i=0;i<n;i++) {
            a[i]=(double *)malloc(sizeof(double)*n); 
            b[i]=(double *)malloc(sizeof(double)*n);
            c[i]=(double *)malloc(sizeof(double)*n);
        }
 
        for(i=0;i<n;i++) {
            for(j=0;j<n;j++) {
                a[i][j]=((rand()%10)+1);
            }
            memcpy((void *)b[i],(const void *)a[i],(size_t)(n*sizeof(double)));
        }
    
        start = omp_get_wtime();

        /*Perform LU decomposition*/
     
        for(k=0;k<n;k++) {
            #pragma omp parallel for default(none) private(j) shared(k,n,a)
            for(j=k+1;j<n;j++) {
                a[k][j]=a[k][j]/a[k][k];//Scaling
            }
//             #pragma omp parallel for collapse(2) default(none) private(i,j) shared(k,n,a)
            #pragma omp parallel for default(none) private(i,j) shared(k,n,a)
            for(i=k+1;i<n;i++) { 
                for(j=k+1;j<n;j++) {
                    a[i][j]=a[i][j]-a[i][k]*a[k][j];
                } 
            }
        }

//         for(k=0;k<n;k++) {
//             #pragma omp parallel for default(none) private(j,i) shared(k,n,a) nowait
//             for(j=k+1;j<n;j++) {
//                 a[k][j]=a[k][j]/a[k][k];//Scaling
                
//                 for(i=k+1;i<n;i++) {
//                     a[i][j]=a[i][j]-a[i][k]*a[k][j];
//                 } 
//             }
//         }

        
        /*end of LU decomposition*/

        printf(" Order %d Operation took %lf seconds ...", n, omp_get_wtime()-start);

        /*Inplace Verification step */
        
        for(i=0;i<n;i++) {
            for(j=0;j<n;j++) {
                c[i][j]=0;

                for(k=0;k<n;k++) {
                    if(i>=k)l1=a[i][k];
                    else l1=0;

                    if(k==j)u1=1;
                    else if(k<j)u1=a[k][j]; 
                    else u1=0.0;

                    c[i][j]=c[i][j]+(l1*u1);

                } 
            }
        }
        flag=0;
        for(i=0;i<n;i++) {
            for(j=0;j<n;j++) {
                if(fabs(c[i][j]-b[i][j])>0.01) {
                    flag=1;
                    break;
                }
            }
        }
 
        if(flag==1) {
            printf(" Error : Not a match\n");
        }
        else printf(" Match\n");
    }
 
    /*Time to free the memory*/
    for(i=0;i<n;i++) {
        free(a[i]);
        free(b[i]);
        free(c[i]);
    }
    free(a);
    free(b);
    free(c);

    return 0;
}


void printMatrix(double **mat,int n) {
    int i,j;
    for(i=0;i<n;i++) {
        for(j=0;j<n;j++) {
            printf("%lf ",mat[i][j]);
        }
        printf("\n");
    }
    printf("------------------------------------------------\n");
}