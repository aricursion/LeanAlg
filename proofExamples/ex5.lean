import LeanAlg.mathMatrix

axiom float_mul_comm (x y : Float) : x * y = y * x

def dot_prod_comm (v w : mathVec m) : v.dot_product w = w.dot_product v :=
  by
    unfold mathVec.dot_product
    simp
    unfold mathVec.foldl
    cases m
    rfl
    apply congrFun 
    

def transpose_of_prod (M : mathMatrix m n) (M' : mathMatrix n k) : (M.multiply M').transpose = (M'.transpose).multiply (M.transpose) :=
  by
    unfold mathMatrix.transpose
    unfold mathMatrix.multiply
    unfold mathMatrix.getCol
    unfold mathMatrix.getRow
    simp
    funext a b
    rw [dot_prod_comm]
