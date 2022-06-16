import LeanAlg.mathVec

-- Proof that setting a value then getting
-- it is equal to the original value
theorem get_of_set_eq (v : mathVec m) (i : Fin m) (x : Float) : (v.set i x).get i = x :=
  by
    unfold mathVec.get
    unfold mathVec.set
    simp
