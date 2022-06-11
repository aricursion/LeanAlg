import Ffi

#check 1.0 < 1.0 ∧ 1.0 > 1.0

def main : IO Unit :=
  do
    let from_array_val := mathVec.get (mathVec.from_array #[1, 2, 3, 2, 4, 5]) (4 : Fin 6)
    IO.eprintln (s!"{from_array_val}")
    let mult_val := mathVec.get ((mathVec.from_array #[6, 12, 24]).scalar_multiply 2) (0 : Fin 3)
    IO.eprintln (s!"{mult_val}")
