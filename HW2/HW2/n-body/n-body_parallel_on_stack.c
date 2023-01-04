#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define SOFTENING 1e-9f

#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))

typedef struct { float x, y, z, vx, vy, vz; } Body;

void randomizeBodies(Body *b, int n) {
    for ( int i=0 ; i<n ; i++ ) {
        b[i].x  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i].y  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i].z  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i].vx = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i].vy = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i].vz = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    }
}

void bodyForce(Body *p, float dt, int n) {
    #pragma omp parallel for default(none) shared(n,p,dt)
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
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

void serialBodyForce(Body *p, float dt, int n) {
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
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
  
    int n_bodies = 20000;

    const float dt = 0.01f; // time step
    const int nIters = 10;  // simulation iterations
    
    double start_time, end_time;
    
    Body seed_bodies[n_bodies], bodies[n_bodies], ref_bodies[n_bodies];
    
    /* Initialize Seed Bodies */

    randomizeBodies(seed_bodies, n_bodies);
    
    /* Set Reference Bodies */
    
    for ( int i=0 ; i<n_bodies ; i++ ) {
        ref_bodies[i] = seed_bodies[i];
    }
    
    /* Solve N-Bodies Serial (Reference) */
        
    for ( int iter=1 ; iter<=nIters; iter++ ) {

        serialBodyForce(ref_bodies, dt, n_bodies); // compute interbody forces

        for ( int i=0 ; i<n_bodies ; i++ ) { // integrate position
            ref_bodies[i].x += ref_bodies[i].vx*dt;
            ref_bodies[i].y += ref_bodies[i].vy*dt;
            ref_bodies[i].z += ref_bodies[i].vz*dt;
        }
    }
    
    /* Solve N-Bodies Parallel */
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};
    
    for ( int x=0 ; x<NELEMS(omp_threads) ; x++ ) {
        int num_threads = omp_threads[x];
        omp_set_num_threads(num_threads);
    
        printf(" Running %d threads ...", num_threads);
        
        for ( int i=0 ; i<n_bodies ; i++ ) {
            bodies[i] = seed_bodies[i];
        }
        
        start_time = omp_get_wtime();
    
        for ( int iter=1; iter<=nIters; iter++ ) {

            bodyForce(bodies, dt, n_bodies); // compute interbody forces

            #pragma omp parallel for default(none) shared(n_bodies,bodies,dt)
            for ( int i=0 ; i<n_bodies ; i++ ) { // integrate position
                bodies[i].x += bodies[i].vx*dt;
                bodies[i].y += bodies[i].vy*dt;
                bodies[i].z += bodies[i].vz*dt;
            }
        }
    
        end_time = omp_get_wtime();
    
        printf(" %d iterations X %d bodies operation took %lf seconds ...", nIters, n_bodies, end_time-start_time);
    
        /* Verification */

        float eps = 1e-6f;

        int is_it_working = 1;

        for ( int i=0 ; i<n_bodies ; i++ ) {
            float err_x  = fabs(bodies[i].x-ref_bodies[i].x);
            float err_y  = fabs(bodies[i].y-ref_bodies[i].y);
            float err_z  = fabs(bodies[i].z-ref_bodies[i].z);
            float err_vx = fabs(bodies[i].vx-ref_bodies[i].vx);
            float err_vy = fabs(bodies[i].vy-ref_bodies[i].vy);
            float err_vz = fabs(bodies[i].vz-ref_bodies[i].vz);
            if ( ( err_x > eps ) || ( err_y > eps ) || ( err_z > eps ) || ( err_vx > eps ) || ( err_vy > eps ) || ( err_vz > eps ) ) {
                printf(" Error in calculation. For body %d: (reference,calc) x=%f,%f, y=%f,%f, z=%f,%f, vx=%f,%f, vy=%f,%f, vz=%f,%f ...", i, bodies[i].x, ref_bodies[i].x, bodies[i].y, ref_bodies[i].y, bodies[i].z, ref_bodies[i].z, bodies[i].vx, ref_bodies[i].vx, bodies[i].vy, ref_bodies[i].vy, bodies[i].vz, ref_bodies[i].vz);
                is_it_working = 0;
                break;
            }
        }
        if (is_it_working == 1) printf(" Yippee Ki-Yay M*th*rf*ck*r It worked!\n");
        else printf("Oops...Try again!\n");
    }
}