#include <lean/lean.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "../utils/utils.h"

typedef struct mathMatrix {
    double*   data;
    uint32_t  rows;
    uint32_t  columns;
} mathMatrix;

//good
static lean_external_class* g_mathMatrix_external_class = NULL;

extern lean_object* l_instInhabitedFloat;

//good
void mathMatrix_finalizer(void* v_) {
    mathMatrix* v = (mathMatrix*) v_;
    if (v->data) {
        free(v->data);
    }
    free(v);
}
//good
// void noop_foreach(void* mod, b_lean_obj_arg fn) {}
//good
lean_obj_res mathMatrix_initialize() {
    g_mathMatrix_external_class = lean_register_external_class(
        mathMatrix_finalizer,
        noop_foreach
    );
    return lean_io_result_mk_ok(lean_box(0));
}

//good
mathMatrix* mathMatrix_alloc(uint32_t rows, uint32_t columns){
    mathMatrix* out = (mathMatrix*) malloc(sizeof(mathMatrix));
    if (out == NULL) {
        printf("Insufficient Memory\n");
    }

    out->data = (double*)(malloc(sizeof(double)*rows*columns));
    if (out->data == NULL) {
        printf("Insufficient Memory\n");
    }
    out->rows = rows;
    out->columns = columns;

    return out;
}

// causing a segfault
// Not sure if I even need this
lean_object* mathMatrix_boxer(mathMatrix* v) {
    return lean_alloc_external(g_mathMatrix_external_class, v);
}
//good
mathMatrix* mathMatrix_unboxer(lean_object* o) {
    return (mathMatrix*) lean_get_external_data(o);
}

lean_object* mathMatrix_new(lean_object* rows_, lean_object* cols_, double val) {
    uint32_t rows = lean_unbox_uint32(rows_);
    uint32_t cols = lean_unbox_uint32(cols_);

    if (rows == 0 || cols == 0) {
        return make_error("invalid rows/cols");
    }

    mathMatrix* m = mathMatrix_alloc(rows,cols);

    if (!m) {
        return make_error("ERROR_INSUF_MEM");
    }

    for (size_t i = 0; i < cols; i++) {
        for (size_t j = 0; j < rows; j++) {
            m->data[j*i + j] = val;
        }
    }

    m->rows = rows;
    m->columns = cols;
    lean_object* out = mathMatrix_boxer(m);

    return out;
}

//todo
double mathMatrix_get_val(lean_object* rows_, lean_object* cols, lean_object* mat) {
    return 0;
}
