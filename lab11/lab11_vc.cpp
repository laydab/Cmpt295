#include "lab11.h"
#include "version2/vectorclass.h"
#include <assert.h>


double dot_double_vc(double* arr1, double* arr2, uint64_t n) {
    assert (n % 4 == 0);
    Vec4d acc = Vec4d(0);
    Vec4d tmpA;
    Vec4d tmpB;

    for (uint64_t i = 0; i < n; i += 4) {
        tmpA.load(arr1 + i);
        tmpB.load(arr2 + i);
        acc += tmpA * tmpB;
        
    }

    return horizontal_add(acc);
}

float dot_single_vc(float* arr1, float* arr2, uint64_t n) {
        assert (n % 8 == 0);

        Vec8f acc = Vec8f(0);
        Vec8f tmpA;
        Vec8f tmpB;

        for (uint64_t i = 0; i < n; i += 8) {

            tmpA.load(arr1 + i);
            tmpB.load(arr2 + i);
            acc += tmpA * tmpB;
            
        }

        return horizontal_add(acc);
    
}

void map_poly_double_vc(double* input, double* output, uint64_t length, double a, double b, double c, double d) {

    assert (length % 4 == 0);

    Vec4d aVec = Vec4d(a);
    Vec4d bVec = Vec4d(b);
    Vec4d cVec = Vec4d(c);
    Vec4d dVec = Vec4d(d);
    Vec4d x;
    Vec4d result;
    
    for (uint64_t i = 0; i < length; i += 4) {

        x.load(input + i);

        result = (aVec)*(x*x*x) + (bVec)*(x*x) + (cVec)*x + dVec;
        result.store(output + i);
    }
}

void map_poly_single_vc(float* input, float* output, uint64_t length, float a, float b, float c, float d) {

    assert (length % 8 == 0);

    Vec8f aVec = Vec8f(a);
    Vec8f bVec = Vec8f(b);
    Vec8f cVec = Vec8f(c);
    Vec8f dVec = Vec8f(d);
    Vec8f x;
    Vec8f result;
    
    for (uint64_t i = 0; i < length; i += 8) {

        x.load(input + i);

        result = (aVec)*(x*x*x) + (bVec)*(x*x) + (cVec)*x + dVec;
        result.store(output + i);
    }
}
