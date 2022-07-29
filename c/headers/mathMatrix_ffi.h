#include <lean/lean.h>
#include "structs.h"

//good
void mathMatrix_finalizer(void* M_);

//good
lean_obj_res mathMatrix_initialize();
//functions for interacting with the struct

//good
mathMatrix* mathMatrix_alloc(uint32_t rows, uint32_t columns);


double mathMatrix_struct_get(mathMatrix* M, uint32_t i, uint32_t j); 


void mathMatrix_struct_set(mathMatrix* M, uint32_t i, uint32_t j, double val);

mathMatrix* mathMatrix_struct_copy(mathMatrix* M);

lean_object* mathMatrix_boxer(mathMatrix* M);

//good
mathMatrix* mathMatrix_unboxer(lean_object* o);

lean_object* mathMatrix_new(lean_object* rows_, lean_object* cols_, double val);


uint8_t mathMatrix_isEqv(lean_object* m, lean_object* n, lean_object* M1_, lean_object* M2_);

double mathMatrix_get_val(lean_object* rows_, lean_object* cols_, lean_object* M_, lean_object* i_, lean_object* j_);

lean_object* mathMatrix_set_val(lean_object* rows_, lean_object* cols_, lean_object* M_, lean_object* i_, lean_object* j_, double x); 


lean_object* mathMatrix_getRow(lean_object* rows_, lean_object* cols_, lean_object* M_, lean_object* row_);


lean_object* mathMatrix_transpose(lean_object* rows_, lean_object* cols_, lean_object* M_);


lean_object* mathMatrix_mul(lean_object* m_, lean_object* n_, lean_object* k_, lean_object* M1_, lean_object* M2_);
