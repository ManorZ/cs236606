#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define SOFTENING 1e-9f

#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))

void *memcpy(void *str1,const void *str2,size_t n);

typedef struct { float x, y, z, vx, vy, vz; } Body;

void randomizeBodies(Body **p, int n) {
    for ( int i=0 ; i<n ; i++ ) {
        p[i]->x = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        p[i]->y = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        p[i]->z = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        p[i]->vx = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        p[i]->vy = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        p[i]->vz = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    }
}

void bodyForce(Body **p, float dt, int n) {
    #pragma omp parallel for default(none) shared(n,p,dt)
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
            float dx = p[j]->x - p[i]->x;
            float dy = p[j]->y - p[i]->y;
            float dz = p[j]->z - p[i]->z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i]->vx += dt*Fx; p[i]->vy += dt*Fy; p[i]->vz += dt*Fz;
    }
}

void SerialbodyForce(Body **p, float dt, int n) {
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
            float dx = p[j]->x - p[i]->x;
            float dy = p[j]->y - p[i]->y;
            float dz = p[j]->z - p[i]->z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i]->vx += dt*Fx; p[i]->vy += dt*Fy; p[i]->vz += dt*Fz;
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
    Body **seed_buf = (Body**)malloc(sizeof(Body*)*nBodies);
    
    /* Allocate Main Bodies */
    Body **buf = (Body**)malloc(sizeof(Body*)*nBodies);
    
    /* Allocate Reference Bodies */
    Body **ref_buf = (Body**)malloc(sizeof(Body*)*nBodies);
    
    for (int i = 0 ; i < nBodies; i++) {
        seed_buf[i] = (Body*)malloc(sizeof(Body));
        buf[i] = (Body*)malloc(sizeof(Body));
        ref_buf[i] = (Body*)malloc(sizeof(Body));
    }
    
    /* Initialize Seed Bodies */

    randomizeBodies(seed_buf, nBodies);
    
    /* Set Reference Bodies */
    
    for ( int i=0 ; i<nBodies ; i++ ) {
        memcpy((void *)ref_buf[i],(const void *)seed_buf[i],(size_t)sizeof(Body));
    }
    
    /* Solve N-Bodies Serial (Reference) */
        
    for (int iter = 1; iter <= nIters; iter++) {

        SerialbodyForce(ref_buf, dt, nBodies); // compute interbody forces

        for ( int i=0 ; i<nBodies ; i++ ) { // integrate position
            ref_buf[i]->x += (ref_buf[i]->vx)*dt;
            ref_buf[i]->y += (ref_buf[i]->vy)*dt;
            ref_buf[i]->z += (ref_buf[i]->vz)*dt;
        }
    }
    
    /* Solve N-Bodies Parallel */
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};
    
    for ( int x=0 ; x<NELEMS(omp_threads) ; x++ ) {
        int num_threads = omp_threads[x];
        omp_set_num_threads(num_threads);
    
        printf(" Running %d threads ...", num_threads);
        
        for ( int i=0 ; i<nBodies ; i++ ) {
            memcpy((void *)buf[i],(const void *)seed_buf[i],(size_t)sizeof(Body));
        }
        
        start_time = omp_get_wtime();
    
        for ( int iter=1 ; iter<=nIters ; iter++ ) {

            bodyForce(buf, dt, nBodies); // compute interbody forces

            #pragma omp parallel for default(none) shared(nBodies,buf,dt)
            for ( int i=0 ; i<nBodies ; i++ ) { // integrate position
                buf[i]->x += (buf[i]->vx)*dt;
                buf[i]->y += (buf[i]->vy)*dt;
                buf[i]->z += (buf[i]->vz)*dt;
            }
        }
    
        end_time = omp_get_wtime();
    
        printf(" %d iterations X %d bodies operation took %lf seconds ...", nIters, nBodies, end_time-start_time);
    
        /* Verification */

        float eps = 1e-6f;

        int is_it_working = 1;

        for ( int i=0 ; i<nBodies ; i++ ) {
            float err_x = fabs(buf[i]->x-ref_buf[i]->x);
            float err_y = fabs(buf[i]->y-ref_buf[i]->y);
            float err_z = fabs(buf[i]->z-ref_buf[i]->z);
            float err_vx = fabs(buf[i]->vx-ref_buf[i]->vx);
            float err_vy = fabs(buf[i]->vy-ref_buf[i]->vy);
            float err_vz = fabs(buf[i]->vz-ref_buf[i]->vz);
            if ( ( err_x > eps ) || ( err_y > eps ) || ( err_z > eps ) || ( err_vx > eps ) || ( err_vy > eps ) || ( err_vz > eps ) ) {
                printf(" Error in calculation. For body %d: (reference,calc) x=%f,%f, y=%f,%f, z=%f,%f, vx=%f,%f, vy=%f,%f, vz=%f,%f ...", i, buf[i]->x, ref_buf[i]->x, buf[i]->y, ref_buf[i]->y, buf[i]->z, ref_buf[i]->z, buf[i]->vx, ref_buf[i]->vx, buf[i]->vy, ref_buf[i]->vy, buf[i]->vz, ref_buf[i]->vz);
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