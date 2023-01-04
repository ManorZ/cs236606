#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define SOFTENING 1e-9f

#define NELEMS(x) (sizeof(x)/sizeof((x)[0]))
// Each Body is 24[B]. Cache line is 64[B]. PAD=4 -> 24*4=96[B] -> 24*3=72[B] between Body objects -> promise cache line seperation
#define PAD 4


typedef struct { float x, y, z, vx, vy, vz; } Body;

void randomizeBodies(Body b[][PAD], int n) {
    for ( int i=0 ; i<n ; i++ ) {
        b[i][0].x  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i][0].y  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i][0].z  = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i][0].vx = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i][0].vy = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
        b[i][0].vz = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    }
}

void bodyForce(Body p[][PAD], float dt, int n) {
    #pragma omp parallel for default(none) shared(n,p,dt)
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
            float dx = p[j][0].x - p[i][0].x;
            float dy = p[j][0].y - p[i][0].y;
            float dz = p[j][0].z - p[i][0].z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i][0].vx += dt*Fx; p[i][0].vy += dt*Fy; p[i][0].vz += dt*Fz;
    }
}

void serialBodyForce(Body p[][PAD], float dt, int n) {
    for ( int i=0 ; i<n ; i++ ) { 
        float Fx = 0.0f; float Fy = 0.0f; float Fz = 0.0f;

        for ( int j=0 ; j<n ; j++ ) {
            float dx = p[j][0].x - p[i][0].x;
            float dy = p[j][0].y - p[i][0].y;
            float dz = p[j][0].z - p[i][0].z;
            float distSqr = dx*dx + dy*dy + dz*dz + SOFTENING;
            float invDist = 1.0f / sqrtf(distSqr);
            float invDist3 = invDist * invDist * invDist;

            Fx += dx * invDist3; Fy += dy * invDist3; Fz += dz * invDist3;
        }

        p[i][0].vx += dt*Fx; p[i][0].vy += dt*Fy; p[i][0].vz += dt*Fz;
    }
}

int main(const int argc, const char** argv) {
  
    int n_bodies = 20000;

    const float dt = 0.01f; // time step
    const int nIters = 10;  // simulation iterations
    
    double start_time, end_time;
    
    Body seed_bodies[n_bodies][PAD], bodies[n_bodies][PAD], ref_bodies[n_bodies][PAD];
    
    /* Initialize Seed Bodies */

    randomizeBodies(seed_bodies, n_bodies);
    
    /* Set Reference Bodies */
    
    for ( int i=0 ; i<n_bodies ; i++ ) {
        ref_bodies[i][0] = seed_bodies[i][0];
    }
    
    /* Solve N-Bodies Serial (Reference) */
        
    for ( int iter=1 ; iter<=nIters; iter++ ) {

        serialBodyForce(ref_bodies, dt, n_bodies); // compute interbody forces

        for ( int i=0 ; i<n_bodies ; i++ ) { // integrate position
            ref_bodies[i][0].x += ref_bodies[i][0].vx*dt;
            ref_bodies[i][0].y += ref_bodies[i][0].vy*dt;
            ref_bodies[i][0].z += ref_bodies[i][0].vz*dt;
        }
    }
    
    /* Solve N-Bodies Parallel */
    
    int omp_threads[13] = {1,2,4,6,8,10,12,14,16,18,20,22,24};
    
    for ( int x=0 ; x<NELEMS(omp_threads) ; x++ ) {
        int num_threads = omp_threads[x];
        omp_set_num_threads(num_threads);
    
        printf(" Running %d threads ...", num_threads);
        
        for ( int i=0 ; i<n_bodies ; i++ ) {
            bodies[i][0] = seed_bodies[i][0];
        }
        
        start_time = omp_get_wtime();
    
        for ( int iter=1; iter<=nIters; iter++ ) {

            bodyForce(bodies, dt, n_bodies); // compute interbody forces

            #pragma omp parallel for default(none) shared(n_bodies,bodies,dt)
            for ( int i=0 ; i<n_bodies ; i++ ) { // integrate position
                bodies[i][0].x += bodies[i][0].vx*dt;
                bodies[i][0].y += bodies[i][0].vy*dt;
                bodies[i][0].z += bodies[i][0].vz*dt;
            }
        }
    
        end_time = omp_get_wtime();
    
        printf(" %d iterations X %d bodies operation took %lf seconds ...", nIters, n_bodies, end_time-start_time);
    
        /* Verification */

        float eps = 1e-6f;

        int is_it_working = 1;

        for ( int i=0 ; i<n_bodies ; i++ ) {
            float err_x  = fabs(bodies[i][0].x-ref_bodies[i][0].x);
            float err_y  = fabs(bodies[i][0].y-ref_bodies[i][0].y);
            float err_z  = fabs(bodies[i][0].z-ref_bodies[i][0].z);
            float err_vx = fabs(bodies[i][0].vx-ref_bodies[i][0].vx);
            float err_vy = fabs(bodies[i][0].vy-ref_bodies[i][0].vy);
            float err_vz = fabs(bodies[i][0].vz-ref_bodies[i][0].vz);
            if ( ( err_x > eps ) || ( err_y > eps ) || ( err_z > eps ) || ( err_vx > eps ) || ( err_vy > eps ) || ( err_vz > eps ) ) {
                printf(" Error in calculation. For body %d: (reference,calc) x=%f,%f, y=%f,%f, z=%f,%f, vx=%f,%f, vy=%f,%f, vz=%f,%f ...", i, bodies[i][0].x, ref_bodies[i][0].x, bodies[i][0].y, ref_bodies[i][0].y, bodies[i][0].z, ref_bodies[i][0].z, bodies[i][0].vx, ref_bodies[i][0].vx, bodies[i][0].vy, ref_bodies[i][0].vy, bodies[i][0].vz, ref_bodies[i][0].vz);
                is_it_working = 0;
                break;
            }
        }
        if (is_it_working == 1) printf(" Yippee Ki-Yay M*th*rf*ck*r It worked!\n");
        else printf("Oops...Try again!\n");
    }
}