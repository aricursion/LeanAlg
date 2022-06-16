import LeanAlg.mathMatrix

def transpose_of_transpose (M : mathMatrix m n) : M.transpose.transpose = M :=
  by
    unfold mathMatrix.transpose
    simp
