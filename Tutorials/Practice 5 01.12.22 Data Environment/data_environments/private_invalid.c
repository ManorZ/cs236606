double example(int m, double *A, double *B, double *C) {
 double liveOut = 6;
 
#pragma omp parallel for firstprivate(liveOut)
 for (int i = 0; i < m; i++) {

 }
 liveOut += 5;
 return liveOut;
}