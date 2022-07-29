import LeanAlg.mathMatrix

def id_pow (e : Nat) : mathMatrix.exp (mathMatrix.id n) e = mathMatrix.id n :=
  by 
    induction e 
    case zero => rfl
    case succ e ih =>
      unfold mathMatrix.exp
      simp
      rw [ih]
      sorry

def is_inverses (M N: mathMatrix n n) : Bool :=
  if (M.multiply_MM N == mathMatrix.id n) ∧ (N.multiply_MM M == mathMatrix.id n) then
    true
  else
    false
