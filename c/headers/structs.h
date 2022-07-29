#include <stdlib.h>
#include <stdint.h>

#ifndef STRUCTS_H
#define STRUCTS_H

typedef struct mathMatrix {
    double*   data;
    uint32_t  rows;
    uint32_t  cols;
} mathMatrix;


typedef struct mathVec {
    double*   data;
    uint32_t length;
} mathVec;

#endif

