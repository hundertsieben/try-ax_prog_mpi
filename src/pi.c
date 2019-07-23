// Pi is calculated with numerical integration. The algorithm was
// copied from
// http://www.appentra.com/parallel-computation-pi/
//
// author: Nora Marcus (nora_lynn.marcus@tu-dresden.de) 

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "omp.h"
#include <inttypes.h>
#include <string.h>

double calculate_pi(int);

int main( int argc, char *argv[] ) {

    #ifdef _OPENMP
        printf("Parallel calculation of pi using %d threads.\n", omp_get_max_threads());
        #pragma omp parallel 
        {
            if (omp_get_thread_num()==0){
                printf("Use %d threads.\n ", omp_get_num_threads());
            }
        }
    #else
        printf("Sequential calculation of pi.\n");
    #endif
 
    double pi;
    int iterations=0;
    int i;
 
    iterations = atoi(argv[1]);    
    for (i=0; i<iterations; i=i+1){
            ///////////////////////////
            ////////BENCHMARK//////////
            pi=calculate_pi(9999999);
            ///////////////////////////
    }

    printf("pi is %.10f \n", pi);
    return 0;
}

double calculate_pi(int num_steps){
    int i;
    double sum, x, step;

    x=0;
    sum = 0.0;
    step = 1.0/(double)num_steps;

    #pragma omp parallel private(i,x) 
    {
        #pragma omp for reduction(+:sum) schedule(static)
        for (i=0; i<num_steps; i=i+1){
            x=(i+0.5)*step;
            sum = sum + 4.0/(1.0+x*x);
        }
    }
    return step*sum;
}

