import LeanAlg.mathMatrix


def id_pow (e : Nat) : mathMatrix.exp (mathMatrix.id n) e = mathMatrix.id n :=
  by 
    induction e 
    case zero => rfl
    case succ e ih =>
      unfold mathMatrix.exp
      simp
      rw [ih]
      unfold mathMatrix.multiply_MM
      unfold mathVec.dot_product
      unfold mathMatrix.id
      simp
      funext i j
      apply Eq.symm
      split


