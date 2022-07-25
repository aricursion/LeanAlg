#include <lean/lean.h>
#include "structs.h"
//good
void mathVec_finalizer(void* v_);

//good
lean_obj_res mathVec_initialize();
//good
mathVec* mathVec_alloc(uint32_t length);

lean_object* mathVec_boxer(mathVec* v);

//good
mathVec* mathVec_unboxer(lean_object* o);

lean_object* mathVec_new(lean_object* len_, double val);


uint8_t mathVec_eqv(lean_object* m_, lean_object* v_, lean_object* w_);


lean_object* mathVec_tabulate(lean_object* m_, lean_object* f);

//good
double mathVec_get_val(lean_object* fin_size_, lean_object* x_1, lean_object* x_2);

//good
lean_object* mathVec_set_val(lean_object* fin_size_, lean_object* mathVec_, lean_object* idx_, double val); 
//good
lean_object* mathVec_from_array(lean_object* lean_array_);

lean_object* mathVec_scalar_mult(lean_object* fin_size_, lean_object* mathVec_, double scalar);

lean_object* mathVec_add_vector(lean_object* fin_size_, lean_object* mathVec_v_, lean_object* mathVec_w_);

double mathVec_dot_prod(lean_object* fin_size_, lean_object* mathVec_v_, lean_object* mathVec_w_); 
