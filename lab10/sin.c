#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdint.h>
#include "lab10.h"

void sin_stdlib(double* input, double* output, uint64_t length) {
    for (uint64_t i = 0; i < length; i++) {
        output[i] = sin(input[i]);
    }
}

int main(void) {
    // length of array
    uint64_t length = 10000000;
    
    // allocate the arrays
    double* input = malloc(length * sizeof(double));
    double* output_x87 = malloc(length * sizeof(double));
    double* output_stdlib = malloc(length * sizeof(double));
    
    // fill array with values 
    for (uint64_t i = 0; i < length; i++) {
        input[i] = (double)i / length * 1000;
    }
    
    printf("Testing with %lu elements\n\n", length);
    
    // Test x87
    clock_t start = clock();
    sin_x87(input, output_x87, length);
    clock_t end = clock();
    double time_x87 = (double)(end - start) / CLOCKS_PER_SEC;
    printf("sin_x87 took %7.1f ms\n", time_x87 * 1000);
    
    // Test stdlib
    start = clock();
    sin_stdlib(input, output_stdlib, length);
    end = clock();
    double time_stdlib = (double)(end - start) / CLOCKS_PER_SEC;
    printf("sin_stdlib took %7.1f ms\n", time_stdlib * 1000);
    
    
    free(input);
    free(output_x87);
    free(output_stdlib);
    
    return 0;
}