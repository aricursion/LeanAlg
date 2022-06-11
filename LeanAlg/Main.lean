import Ffi

#check 1.0 < 1.0 ∧ 1.0 > 1.0

def main : IO Unit :=
  do
    let v1 := mathVec.from_array #[1, 2, 3]
    let v2 := mathVec.from_array #[2, 2, 9]
    let add_v1_v2 := @mathVec.add_vector 3 v1 v2
    let val_add := mathVec.get add_v1_v2 2
    IO.eprintln (s!"{val_add}")

    let from_array_val := mathVec.get (mathVec.from_array #[1, 2, 3, 2, 4, 5]) (4 : Fin 6)
    IO.eprintln (s!"{from_array_val}")

    let mult_val := mathVec.get ((mathVec.from_array #[6, 12, 24]).scalar_multiply 2) (0 : Fin 3)
    IO.eprintln (s!"{mult_val}")

    let dot_val := @mathVec.dot_product 3 v1 v2
    IO.eprintln (s!"{dot_val}")

   
