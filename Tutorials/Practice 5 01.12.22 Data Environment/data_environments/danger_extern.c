//File #1
int tmp;
void danger() 
{
   tmp = 0;
   #pragma omp parallel private(tmp)
      work(); 
   printf("%d\n", tmp);   // tmp has unspecified value
}

// File #2
extern int tmp; 
void work() 
{
   tmp = 5; 
}

