

////////////////////////////////// exmaple 1: target; map

#pragma omp target map(a,b,c,d)
{
    for (int i=0; i<N; i++) {
        a[i] b[i]*c + d;
    }
} //end of target 




///////////////////////////////// example 2: target; parallel for

#pragma omp target map(a,b,c,d)
{
    #pragma omp parallel for
    for (int i=0; i<N; i++) {
        a[i] b[i]*c + d;
    }
} //end of target 




///////////////////////////////// example 3: illegal memory access

char *hptr = malloc(N);

//Error - Accessing a host address on accelerator
#pragma omp target map(hptr)
for (int i=0; i<N; i++)
    *hptr++ = 0;




///////////////////////////////// example 4: illegal memory access

char *dptr;
#pragma omp target map(dptr)
dptr = malloc(N);

//Error - Accessing a device address on host
for (int i=0; i<N; i++)
    *dptr++ = 0;




///////////////////////////////// example 5: mapping array sections

char *hptr;

hptr = malloc(N);

//Map an array section
#pragma omp target map(hptr[0:N])
for (int i=0; i<N; i++)
    hptr[i] = 0;




///////////////////////////////// example 6: different map-types to the map clause


#include <stdlib.h>
void func(float a[1024], float b[1024], int t[1024])
{
    #pragma omp target map(from:a) map(to:b) map(alloc:t) //map-enter
    {
        int i;
        
        for (i=0; i<1024; i++)
            t[i] = rand()%1024;
        
        for (i=0; i<1024; i++)
            a[i] = b[t[i]];
   
    } //End of target, map-exit 
}





///////////////////////////////// example 7: saxpy with target; teams; map(to); distribute parallel for

void saxpy(float *restrict y, float *restrict x, float a, int n)
{
    #pragma omp target teams map(y[:n]) map(to:x[:n])
    #pragma omp distribute parallel for
    for (int i=0; i<n; i++)
        y[i] = y[i] + a*x[i];
}





///////////////////////////////// example 8: problem with implicit firstprivate variables

void dotp(float *restrict y, float *restrict x, int n)
{
    float sum = 0.0;
    #pragma omp target map(y[:n]) map(to:x[:n])
    {
      for (int i=0; i<n; i++)
        sum+ = y[i] * x[i];
    }
    
    return sum;
}




///////////////////////////////// example 9: Use array section to map a subset of an array; from; firstprivate

#define BIG 256
#define N (1024*1024)
int a[N*BIG];

void F(const int c, const int d) 
{
    for (int k=0; k<N*BIG; k+=N) {
        #pragma omp target map(from:a[k:N]) firstprivate(c,d)
        for (int i=0; i<N; i++) {
            a[k+i] = k+i*(c+d);
        } // End of target
    }
}




///////////////////////////////// example 10: declare target

#pragma omp begin declare target 
extern void fib(int N);
#pragma omp end declare target 

#define THRESHOLD 1000000

void fib_wrapper(int n)
{
   #pragma omp target if(n>THRESHOLD)
    {
        fib(n);
    }
}





///////////////////////////////// example 11: target data region enclosing multiple target regions

extern void init (float*, float*, int);
extern void init_again(float*, float*, int);
extern void output (float*, int);
void vec_mult(float *p, float *v1, float *v2, int N)
{
    int i;
    init(v1, v2, N);
    #pragma omp target data map(from: p[0:N])
    {
        #pragma omp target map(to: v1[:N], v2[:N])
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = v1[i]*v2[i];
        
        init_again(v1,v2,N);
        
        #pragma omp target map(to: v1[:N], v2[:N])
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = p[i] + v1[i]*v2[i];
    }   
    output(p,N);
}




///////////////////////////////// example 12: target update

extern void init (float*, float*, int);
extern void init_again(float*, float*, int);
extern void output (float*, int);
void vec_mult(float *p, float *v1, float *v2, int N)
{
    int i;
    init(v1, v2, N);
    #pragma omp target data map(to: v1[:N], v2[:N]) map(from: p[0:N])
    {
        #pragma omp target 
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = v1[i]*v2[i];
        
        init_again(v1,v2,N);
        
        #pragma omp target update to(v1[:N], v2[:,N])
        
        #pragma omp target 
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = p[i] + v1[i]*v2[i];
    }   
    output(p,N);
}





///////////////////////////////// example 13: target update with if clause

extern void init (float*, float*, int);
extern int maybe_init_again(float*, int);
extern void output (float*, int);
void vec_mult(float *p, float *v1, float *v2, int N)
{
    int i;
    init(v1, v2, N);
    #pragma omp target data map(to: v1[:N], v2[:N]) map(from: p[0:N])
    {
        int changed;
        #pragma omp target 
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = v1[i]*v2[i];
        
        changed = maybe_init_again(v1,N);     
        #pragma omp target update if(changed) to(v1[:N])
        changed = maybe_init_again(v2,N);     
        #pragma omp target update if(changed) to(v2[:N])
        
        #pragma omp target 
        #pragma omp parallel for
        for (i=0; i<N; i++)
            p[i] = p[i] + v1[i]*v2[i];
    }   
    output(p,N);
}




///////////////////////////////// example 14: target data with always

#define N (1024*1024)
double A[N], B[N]; 
extern double F(double * restrict);


void G(double c, double d)
{
    double a;
    #pragma omp target data map(B)
    {
        #pragma omp target map(B) map(always, from:A) firstprivate(c,d)
        for (int i=0; i<N; i++)
            A[i] = B[i]*c + d;
        
        e = F(A);
        
        #pragma omp target map(B) firstprivate(e)
        for(int i=0; i<N; i++)
            B[i] = B[i] /e;
    
    } //end of target data
}


// Note: A may be already mapped by a target data construct before the call to G().





///////////////////////////////// example 15: target data enter/exit

class myArray {
    int length;
    double *ptr;
    
    void allocate(int l) {
       double *p = new double[l];
        ptr = p;
        length = l;
        #pragma omp target enter data map(alloc:p[0:length])
    }
    
    void_release() {
        double *p = ptr;
        #pragma omp target exit data map(release: p[0:length])
        delete[] p;
        ptr = 0;
        length = 0;
    }
        
};




///////////////////////////////// example 16: target with nowait and depend clauses

#pragma omp parallel num_threads(2)
{
    #pragma omp single
    {
        #pragma omp task depend(out:v1)
        init(v1,N);
        
        #pragma omp task depend(out:v2)
        init(v2,N);
        
        #pragma omp target nowait depend(in:v1,v2) depend(out:p) map(to:v1,v2) map(from:p)
        #pragma omp parallel for
        for(int i=0; i<N; i++)
            p[i] = v1[i] * v2[i];
        
        #pragma omp task depend(in:p)
        output(p,N);
    }
    
}



