#include <lean/lean.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct cVec {
    double*   data;
    uint32_t length;
} cVec;

//good
static lean_external_class* g_cVec_external_class = NULL;

extern lean_object* l_instInhabitedFloat;

lean_obj_res make_error(const char* err_msg) {
    return lean_mk_io_user_error(lean_mk_io_user_error(lean_mk_string(err_msg)));
}
//good
void cVec_finalizer(void* v_) {
    cVec* v = (cVec*) v_;
    if (v->data) {
        free(v->data);
    }
    free(v);
}
//good
void noop_foreach(void* mod, b_lean_obj_arg fn) {}
//good
lean_obj_res cVec_initialize() {
    g_cVec_external_class = lean_register_external_class(
        cVec_finalizer,
        noop_foreach
    );
    return lean_io_result_mk_ok(lean_box(0));
}
//good
cVec* cVec_alloc(uint32_t length){
    cVec* out = (cVec*) malloc(sizeof(cVec));
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
lean_object* cVec_boxer(cVec* v) {
    return lean_alloc_external(g_cVec_external_class, v);
}
//good
cVec* cVec_unboxer(lean_object* o) {
    return (cVec*) lean_get_external_data(o);
}

//untested
lean_object* cVec_struct_to_cVec_lean(cVec* c){
    lean_object* out_arr = lean_mk_empty_array_with_capacity(lean_box_uint32(c->length));
    for (size_t i = 0; i < c->length; i++){
        out_arr = lean_array_push(out_arr, lean_box_float(c->data[i]));
    }
    return out_arr;
}

//untested
cVec* cVec_lean_to_cVec_struct(lean_object* lean_arr) {
    uint32_t arr_len = lean_array_size(lean_arr);   
    cVec* v = cVec_alloc(sizeof(double) * arr_len);
    v->length = arr_len;
    for (size_t i = 0; i < arr_len; i++) {
        v->data[i] = lean_unbox_float(lean_array_uget(lean_arr, i));
    }
    return v;
}

lean_object* cVec_new(lean_object* len_, double val) {
    uint32_t len = lean_unbox_uint32(len_);
    printf("len %u\n", len);

    if (len == 0) {
        return make_error("invalid length");
    }

    cVec* v = cVec_alloc(sizeof(double)*len);
    if (!v) {
        return make_error("ERROR_INSUF_MEM");
    }
    for (size_t i = 0; i < len; i++) {
        v->data[i] = val;
    }
    lean_object* out_arr = lean_mk_empty_array_with_capacity(len_);
    for (size_t i = 0; i < len; i++){
        out_arr = lean_array_push(out_arr, lean_box_float(val));
    }
    return out_arr;
}

//good
double cVec_get_val(lean_object* x_1, lean_object* x_2) {
    lean_object* x_4; lean_object* x_5; 
    x_4 = l_instInhabitedFloat;
    x_5 = lean_array_get(x_4, x_1, x_2);
    return lean_unbox_float(x_5);
}
//good
double cVec_dot_prod(lean_object* lean_arr_v, lean_object* lean_arr_w){
    double out = 0;
    for (size_t i = 0; i < lean_array_size(lean_arr_v); i++){
        out += lean_unbox_float(lean_array_uget(lean_arr_v, i)) * lean_unbox_float(lean_array_uget(lean_arr_w, i));
    }
    return out;
}
