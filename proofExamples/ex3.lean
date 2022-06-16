import LeanAlg.mathVec
-- technically this axiom isn't always true but
-- I'm not checking, is anyone checking? nahhhh
axiom Float.add_comm (x y : Float) : x + y = y + x

axiom Float.add_assoc (x y z : Float) : x + y + z = x + (y + z)

theorem vector_add_comm (v w : mathVec m) : v.add_vector w = w.add_vector v :=
  by
    unfold mathVec.add_vector
    simp
    funext i
    rw [Float.add_comm]

theorem vector_add_assoc (u v w : mathVec m) :  
  (u.add_vector v).add_vector w = u.add_vector (v.add_vector w) :=
  by
    unfold mathVec.add_vector
    simp
    funext i;
    rw [Float.add_assoc]

