#include <lean/lean.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "../utils/utils.h"
#include "mathMatrix_ffi.h"
typedef struct mathVec {
    double*   data;
    uint32_t length;
} mathVec;

//good
static lean_external_class* g_mathVec_external_class = NULL;

extern lean_object* l_instInhabitedFloat;

//good
void mathVec_finalizer(void* v_) {
    mathVec* v = (mathVec*) v_;
    if (v->data) {
        free(v->data);
    }
    free(v);
}
//good
lean_obj_res mathVec_initialize() {
    g_mathVec_external_class = lean_register_external_class(
        mathVec_finalizer,
        noop_foreach
    );
    return lean_io_result_mk_ok(lean_box(0));
}
//good
mathVec* mathVec_alloc(uint32_t length){
    mathVec* out = (mathVec*) malloc(sizeof(mathVec));
    if (out == NULL) {
        printf("Insufficient Memory\n");
    }

    out->data = (double*)(malloc(sizeof(double)*length));
    if (out->data == NULL) {
        printf("Insufficient Memory\n");
    }
    out->length = length;

    return out;
}

// causing a segfault
// Not sure if I even need this
lean_object* mathVec_boxer(mathVec* v) {
    return lean_alloc_external(g_mathVec_external_class, v);
}
//good
mathVec* mathVec_unboxer(lean_object* o) {
    return (mathVec*) lean_get_external_data(o);
}

lean_object* mathVec_new(lean_object* len_, double val) {
    uint32_t len = lean_unbox_uint32(len_);
    printf("len %u\n", len);

    if (len == 0) {
        return make_error("invalid length");
    }

    mathVec* v = mathVec_alloc(sizeof(double)*len);
    if (!v) {
        return make_error("ERROR_INSUF_MEM");
    }
    for (size_t i = 0; i < len; i++) {
        v->data[i] = val;
    }
    v->length = len;
    lean_object* out = mathVec_boxer(v);

    return out;
}

uint8_t mathVec_eqv(lean_object* m_, lean_object* v_, lean_object* w_) {
    mathVec* v = mathVec_unboxer(v_);
    mathVec* w = mathVec_unboxer(w_);
    for (size_t i = 0; i < v->length; i++) {
        if (v->data[i] != w->data[i])
            return 0;
    }

    return 1;
}

lean_object* l_Fin_ofNat(lean_object*, lean_object*);

lean_object* mathVec_tabulate(lean_object* m_, lean_object* f) {
    uint32_t m = lean_unbox_uint32(m_);
    mathVec* out = mathVec_alloc(m);
    for (uint32_t i = 0; i < m; i++) {
        lean_object* inat = lean_unsigned_to_nat(i);
        lean_object* ifin = l_Fin_ofNat(lean_unsigned_to_nat(m-1), inat);
        out->data[i] = lean_unbox_float(lean_apply_1(f, ifin));
    }

    return mathVec_boxer(out);
}

//good
double mathVec_get_val(lean_object* fin_size_, lean_object* x_1, lean_object* x_2) {
    mathVec* v = mathVec_unboxer(x_1);
    uint32_t idx = lean_unbox_uint32(x_2);
    return v->data[idx];
}

//good
lean_object* mathVec_set_val(lean_object* fin_size_, lean_object* mathVec_, lean_object* idx_, double val) {
    mathVec* v = mathVec_unboxer(mathVec_);
    uint32_t idx = lean_unbox_uint32(idx_);
    
    mathVec* out_struct = mathVec_alloc(v->length);
    for (size_t i =0; i < v->length; i++) {
        out_struct->data[i] = v->data[i];
    }

    out_struct->data[idx] = val;
    lean_object* out_lean = mathVec_boxer(out_struct);
    return out_lean;
}

//good
lean_object* mathVec_from_array(lean_object* lean_array_) {
    uint32_t size = lean_array_size(lean_array_);
    mathVec* out = mathVec_alloc(size);
    for (size_t i = 0; i < size; i++) {
        out->data[i] = lean_unbox_float(lean_array_uget(lean_array_, i));
    }
    out->length = size;
    return mathVec_boxer(out);
}

lean_object* mathVec_scalar_mult(lean_object* fin_size_, lean_object* mathVec_, double scalar) {
    mathVec* mVec = mathVec_unboxer(mathVec_);
    for (size_t i = 0; i < mVec->length; i++) {
        mVec->data[i] *= scalar;
    }
    return mathVec_boxer(mVec);
}

lean_object* mathVec_add_vector(lean_object* fin_size_, lean_object* mathVec_v_, lean_object* mathVec_w_) {
    mathVec* vVec = mathVec_unboxer(mathVec_v_);
    mathVec* wVec = mathVec_unboxer(mathVec_w_);
    uint32_t fin_size = lean_unbox_uint32(fin_size_);
    
    assert(vVec->length == fin_size && wVec->length == fin_size);
    mathVec* out = mathVec_alloc(fin_size);
    out->length = fin_size;

    for (size_t i = 0; i < vVec->length; i++) {
         out->data[i] += vVec->data[i] + wVec->data[i];
    }

    lean_object* lean_out = mathVec_boxer(out);
    return lean_out;
}

double mathVec_dot_prod(lean_object* fin_size_, lean_object* mathVec_v_, lean_object* mathVec_w_) {
    mathVec* vVec = mathVec_unboxer(mathVec_v_);
    mathVec* wVec = mathVec_unboxer(mathVec_w_);
    uint32_t fin_size = lean_unbox_uint32(fin_size_);
    
    assert(vVec->length == fin_size && wVec->length == fin_size);
    double out = 0;
    for (size_t i = 0; i < vVec->length; i++) {
        out += vVec->data[i] * wVec->data[i];
    }
    return out;
}
