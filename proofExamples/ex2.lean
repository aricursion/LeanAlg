import Ffi

-- Proof that multiplying before and after
-- getting results in the same value
theorem get_of_mult (v : mathVec m) (i : Fin m) (s : Float): s * v.get i = (v.scalar_multiply s).get i:=
  by
    unfold mathVec.scalar_multiply
    unfold mathVec.get
    simp
