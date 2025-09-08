#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int array_sum(int32_t *arr, uint32_t n){
    uint32_t sum = 0;
    for (int i = 0; i < n; i++){
        sum += arr[i];
    }
    return sum;
}