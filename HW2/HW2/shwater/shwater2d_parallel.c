/*
 *  shwater2d.c solves the two dimensional shallow water equations 
 *  using the Lax-Friedrich's scheme
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>

#define cell_size 3
#define xstart 0.0
#define ystart 0.0
#define xend 4.0
#define yend 4.0

#define Q(i, j, k) Q[((k) + n * ((j) + m * (i)))]
#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))


/* Check that the solution is finite */
void validate(double *Q, int m, int n) {
    int i, j, k;
    for (i = 0; i < n; i++) 
        for (j = 0; j < m; j++) 
            for (k = 0; k < cell_size;  k++)
                if (!isfinite(Q(k, j, i))) {
                    fprintf(stderr, "Invalid solution of parallel solver\n");
                    exit(-1);
                }
}

void print(double *Q, int m, int n) {
    int i, j, k;
    printf("Q=\n");
    for (k = 0; k < cell_size;  k++) {
        printf("[\n");
        for (i = 0; i < n; i++) {
            printf("\t[");
            for (j = 0; j < m; j++) {
                if (Q(k, j, i) < 0) printf("%.3f,", Q(k, j, i));
                else printf("%.4f,", Q(k, j, i));
            }
            printf("]\n");
        }
        printf("]\n\n");
    }
}

/* Flux function in the x-direction */
void fx(double *Q, double **fq, int m, int n, int j) {  
    int i;
    const double g = 9.81;

    for (i = 0; i < m; i++) {
        fq[0][i] = Q(1, i, j);
        fq[1][i] = (pow(Q(1, i, j), 2) / Q(0, i, j)) + (g * pow(Q(0, i, j), 2)) / 2.0;
        fq[2][i] = (Q(1, i, j) * Q(2, i, j)) / Q(0, i, j);
    }
}

/* Flux function in the y-direction */
void fy(double *Q, double **fq, int m, int n, int i) {
    int j;
    const double g= 9.81;

    for (j = 0; j < n; j++) {
        fq[0][j] = Q(2, i, j);
        fq[1][j] = (Q(1, i, j) * Q(2, i, j)) / Q(0, i, j);    
        fq[2][j] = (pow(Q(2, i, j), 2) / Q(0, i, j))  + (g * pow(Q(0, i, j), 2)) / 2.0;
    }
}


/*
  This is the Lax-Friedrich's scheme for updating volumes
*/
void laxf_scheme_2d(double *Q, double **ffx, double **ffy, double **nFx, double **nFy, int m, int n, double dx, double dy, double dt) {
    
    int i, j, k;
    
    /* Calculate and update fluxes in the x-direction */
    #pragma omp for
    for (i = 1; i < n; i++) {
        fx(Q, ffx, m, n, i);
        for (j = 1; j < m; j++)
            for (k = 0; k < cell_size;  k++)
                nFx[k][j] = 0.5 * ((ffx[k][j-1] + ffx[k][j]) - dx/dt * (Q(k, j, i) - Q(k, j-1, i)));
        for (j = 1; j < m-1; j++)
            for (k = 0; k < cell_size;  k++) 
                Q(k, j, i) = Q(k, j, i)  - dt/dx * ((nFx[k][j+1] - nFx[k][j]));
    }
    
    /* Calculate and update fluxes in the y-direction */
    #pragma omp for
    for (i = 1; i < m; i++) {
        fy(Q, ffy, m, n, i);
        for (j = 1; j < n; j++)
            for (k = 0; k < cell_size; k++)
                nFy[k][j] = 0.5 * ((ffy[k][j-1] + ffy[k][j]) - dy/dt * (Q(k, i, j) - Q(k, i, j -1)));
        for (j = 1; j <  n-1; j++) 
            for (k = 0; k < cell_size; k++)
                Q(k,i,j) = Q(k,i,j) -  dt/dy * ((nFy[k][j+1]  -  nFy[k][j]));
    }
}


void solver(double *Q, double **ffx, double **ffy, double **nFx, double **nFy, int m, int n, double tend, double dx, double dy, double dt) {
    double bc_mask[3] = {1.0, -1.0, -1.0};
    double stime, etime;
    int i, j, k, steps;
    
    steps = ceil(tend / dt);
    
    #pragma omp parallel private(i, j, k, ffx, ffy, nFx, nFy)
    {
        /* Allocate memory for fluxes */
        ffx = (double **) malloc(cell_size * sizeof(double *));
        ffy = (double **) malloc(cell_size * sizeof(double *));
        nFx = (double **) malloc(cell_size * sizeof(double *));
        nFy = (double **) malloc(cell_size * sizeof(double *));
    
        ffx[0] = (double *) malloc(cell_size * m * sizeof(double));
        ffy[0] = (double *) malloc(cell_size * m * sizeof(double));
        nFx[0] = (double *) malloc(cell_size * n * sizeof(double));
        nFy[0] = (double *) malloc(cell_size * n * sizeof(double));

        for (i = 0; i < cell_size; i++) {
            ffx[i] =  ffx[0] + i * m;
            nFx[i] =  nFx[0] + i * m;
            ffy[i] =  ffy[0] + i * n;
            nFy[i] =  nFy[0] + i * n;
        }
        
        #pragma omp master
        stime = omp_get_wtime();
        
        for (i = 0; i < steps; i++) {
            /* Apply boundary condition */
            #pragma omp for
            for (j = 1; j < n - 1 ; j++) {
                for (k = 0; k < cell_size; k++) {
                    Q(k, 0, j) = bc_mask[k] *  Q(k, 1, j);
                    Q(k, m-1, j) = bc_mask[k] *  Q(k, m-2, j);
                }
            }
            #pragma omp for
            for (j = 0; j < m; j++)  {
                for (k = 0; k < cell_size; k++) {
                    Q(k, j, 0) = bc_mask[k] * Q(k, j, 1);
                    Q(k, j, n-1) = bc_mask[k] * Q(k, j, n-2);
                }
            }
            
            /* Update all volumes with the Lax-Friedrich's scheme */
            laxf_scheme_2d(Q, ffx, ffy, nFx, nFy, m, n, dx, dy, dt);   
        }
        
        #pragma omp master
        {
            etime = omp_get_wtime();
            printf(" Order %d,%d Solver took %lf seconds ...", m, n, etime - stime);
        }
        
        free(ffx[0]);
        free(ffy[0]);
        free(nFx[0]);
        free(nFy[0]);

        free(ffx);
        free(ffy);
        free(nFx);
        free(nFy);
    }
}
  
/*
  This is the main routine of the program, which allocates memory 
  and setup all parameters for the problem.
  
  You don't need to parallelize anything here!
  
  However, it might be useful to change the m and n parameters 
  during debugging
*/
int main(int argc, char **argv) {
  
    int i, j, m, n;
    double *Q;
    double *x, *y;
    double **ffx, **nFx, **ffy, **nFy;
    double dx, dt, epsi, delta, dy, tend, tmp, stime, etime;
  
    /* Use m volumes in the x-direction and n volumes in the y-direction */    
    m = 1000;
    n = 1000;
//     m = 10;
//     n = 10;
    
    /* Add two ghost volumes at each side of the domain */
    m = m + 2;
    n = n + 2;
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};
    
    for ( int z=0; z<NELEMS(omp_threads); z++ ) {
        int num_threads = omp_threads[z];
        omp_set_num_threads(num_threads);
        
        printf(" Running %d threads ...", num_threads);

        /*
        epsi      Parameter used for initial condition
        delta     Parameter used for initial condition
        dx        Distance between two volumes (x-direction)
        dy        Distance between two volumes (y-direction)
        dt        Time step
        tend      End time
        */
        epsi = 2.0;
        delta = 0.5;
        dx = (xend - xstart) / (double) m;
        dy = (yend - ystart) / (double) n;
        dt = dx / sqrt( 9.81 * 5.0);
        tend = 0.1;
  
        /* Allocate memory for the domain */
        Q = (double *) malloc(m * n * cell_size *  sizeof(double));

        x = (double *) malloc(m * sizeof(double));
        y = (double *) malloc(n * sizeof(double));

        for (i = 0,tmp= -dx/2 + xstart; i < m; i++, tmp += dx)
            x[i] = tmp;

        for (i = 0,tmp= -dy/2 + ystart; i < n; i++, tmp += dy)
            y[i] = tmp;

        /* Set initial Gauss hump */
        for (i = 0; i < m; i++) {
            for (j = 0; j < n; j++) {
                Q(0, i, j) = 4.0;
                Q(1, i, j) = 0.0;
                Q(2, i, j) = 0.0;
            }
        }

        for (i = 1; i < m-1; i++) {
            for (j = 1; j < n-1; j++) {
                Q(0, i, j) = 4.0 + epsi * exp(-(pow(x[i] - xend / 4.0, 2) + pow(y[j] - yend / 4.0, 2)) / (pow(delta, 2)));
            }
        }

        solver(Q, ffx, ffy, nFx, nFy, m, n, tend, dx, dy, dt);

        printf("Validating ...");
        validate(Q, m, n);
        printf("Works!\n");

//         print(Q,m,n);

        free(Q);
        free(x);
        free(y);
    }

    return 0;    
}