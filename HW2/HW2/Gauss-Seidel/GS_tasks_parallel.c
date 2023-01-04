
void gauss_seidel(int tsteps, int size, double **p) {
      #pragma omp parallel shared(p)
      {
      // One thread create the tasks
      // The single thread will wait on the pragma omp parallel implicit barrier
      #pragma omp single nowait
      {
      for (int t = 0; t < tsteps; ++t) {
         for (int i = 1; i < size-1; ++i) {
            for (int j = 1; j < size-1; ++j) {   
               //create a different task for each update
               //#pragma omp taskwait
               // Each task is dependent on the output of its left task and the output of its upper task. Also, its bottom and right tasks will be dependent on it.
               #pragma omp task depend(inout:p[i][j-1],p[i-1][j])
               p[i][j] = 0.25 * (p[i][j-1] + // left
                                 p[i][j+1] + // right
                                 p[i-1][j] + // top
                                 p[i+1][j]); // bottom
            }
         }
      }
      }
      }
   }
}
