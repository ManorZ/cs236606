

/*
Note:
The priority-value ranges from 0 to a maximum value indicated by the max-task-priority-var Internal control variable (ICV). 
By default, the max-task-priority-var ICV is zero.
It can be set by through the environment variable OMP_MAX_TASK_PRIORITY.
For example, to set the maximum priority to 50 under the Bash shell, you would use the following commands:

export OMP_MAX_TASK_PRIORITY=50

To query the value of the OMP_MAX_TASK_PRIORITY ICV, you can use the function:

int omp_get_max_task_priority(void);

Unlike the other ICVs, there is no runtime library routine to set max-task-priority-var.


*/
void compute_array (float *node, int M);

void compute_matrix (float *array, int N, int M)
{
    int i;
    #pragma omp parallel private(i)
    #pragma omp single
    {
      for (int i=0; i<N; i++)
      {
          #pragma omp task priority(i)
          compute_array(&array[i*M],M);
      }
        
    }   
    
}