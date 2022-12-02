#include <stdio.h>
#include <omp.h>

void print_thread_iter(int i, int thread_id, int n_threads) {
    printf("T %d/%d @ %d\n", thread_id, n_threads, i);
}

int main(int argc, char** argv){

    #pragma omp parallel
    {
        #pragma omp for
        for(int i=0; i<100; i++) {
            int thread_id = omp_get_thread_num() + 1;
            int n_threads = omp_get_num_threads();
            print_thread_iter(i, thread_id, n_threads);
        }
    }
    
    return 0;
}
