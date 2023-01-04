#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define SOFTENING 1e-9f

#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))

void *memcpy(void *str1,const void *str2,size_t n);

typedef struct { float x, y, z, vx, vy, vz; } Body;

void randomizeBodies(float *data, int n) {
  for (int i = 0; i < n; i++) {
    data[i] = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
  }
}

void bodyForce(Body *p, float dt, int n) {
    #pragma omp parallel for default(none) shared(n,p,dt)
    for (int i = 0; i < n; i++) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for (int j = 0; j < n; j++) {
            float dx = p[j].x - p[i].x;
            float dy = p[j].y - p[i].y;
            float dz = p[j].z - p[i].z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i].vx += dt*Fx; p[i].vy += dt*Fy; p[i].vz += dt*Fz;
    }
}

void SerialbodyForce(Body *p, float dt, int n) {
    for (int i = 0; i < n; i++) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for (int j = 0; j < n; j++) {
            float dx = p[j].x - p[i].x;
            float dy = p[j].y - p[i].y;
            float dz = p[j].z - p[i].z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i].vx += dt*Fx; p[i].vy += dt*Fy; p[i].vz += dt*Fz;
    }
}

int main(const int argc, const char** argv) {
  
    int nBodies = 20000;
    if (argc > 1) nBodies = atoi(argv[1]);

    const float dt = 0.01f; // time step
    const int nIters = 10;  // simulation iterations
    
    double start_time, end_time;
    
    int bytes = nBodies*sizeof(Body);
    
    /* Allocate Seed Bodies */
    
    float *seed_buf = (float*)malloc(bytes);
    Body *seed_p = (Body*)seed_buf;
    
    /* Allocate Main Bodies */
    
    float *buf = (float*)malloc(bytes);
    Body *p = (Body*)buf;
    
    /* Allocate Reference Bodies */
    
    float *ref_buf = (float*)malloc(bytes);
    Body *ref_p = (Body*)ref_buf;
    
    /* Initialize Seed Bodies */

    randomizeBodies(seed_buf, 6*nBodies);
    
    /* Set Reference Bodies */
    
    memcpy((void *)ref_buf,(const void *)seed_buf,(size_t)bytes);
    
    /* Solve N-Bodies Serial (Reference) */
        
    for (int iter = 1; iter <= nIters; iter++) {

        SerialbodyForce(ref_p, dt, nBodies); // compute interbody forces

        for (int i = 0 ; i < nBodies; i++) { // integrate position
            ref_p[i].x += ref_p[i].vx*dt;
            ref_p[i].y += ref_p[i].vy*dt;
            ref_p[i].z += ref_p[i].vz*dt;
        }
    }
    
    /* Solve N-Bodies Parallel */
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};
    
    for ( int x=0; x<NELEMS(omp_threads); x++ ) {
        int num_threads = omp_threads[x];
        omp_set_num_threads(num_threads);
    
        printf(" Running %d threads ...", num_threads);
        
        memcpy((void *)buf,(const void *)seed_buf,(size_t)bytes);
        
        start_time = omp_get_wtime();
    
        for (int iter = 1; iter <= nIters; iter++) {

            bodyForce(p, dt, nBodies); // compute interbody forces

            #pragma omp parallel for default(none) shared(nBodies,p,dt)
            for (int i = 0 ; i < nBodies; i++) { // integrate position
                p[i].x += p[i].vx*dt;
                p[i].y += p[i].vy*dt;
                p[i].z += p[i].vz*dt;
            }
        }
    
        end_time = omp_get_wtime();
    
        printf(" %d iterations X %d bodies operation took %lf seconds ...", nIters, nBodies, end_time-start_time);
    
        /* Verification */

        float eps = 1e-6f;

        int is_it_working = 1;

        for (int i = 0 ; i < nBodies; i++) {
            float err_x = fabs(p[i].x-ref_p[i].x);
            float err_y = fabs(p[i].y-ref_p[i].y);
            float err_z = fabs(p[i].z-ref_p[i].z);
            float err_vx = fabs(p[i].vx-ref_p[i].vx);
            float err_vy = fabs(p[i].vy-ref_p[i].vy);
            float err_vz = fabs(p[i].vz-ref_p[i].vz);
            if ( ( err_x > eps ) || ( err_y > eps ) || ( err_z > eps ) || ( err_vx > eps ) || ( err_vy > eps ) || ( err_vz > eps ) ) {
                printf(" Error in calculation. For body %d: (reference,calc) x=%f,%f, y=%f,%f, z=%f,%f, vx=%f,%f, vy=%f,%f, vz=%f,%f ...", i, p[i].x, ref_p[i].x, p[i].y, ref_p[i].y, p[i].z, ref_p[i].z, p[i].vx, ref_p[i].vx, p[i].vy, ref_p[i].vy, p[i].vz, ref_p[i].vz);
                is_it_working = 0;
                break;
            }
        }
        if (is_it_working == 1) printf(" Yippee Ki-Yay M*th*rf*ck*r It worked!\n");
        else printf("Oops...Try again!\n");
    }
    
    /*Time to free the memory*/
        
    free(seed_buf);
    free(buf);
    free(ref_buf);
}