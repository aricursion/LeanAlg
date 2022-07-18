import LeanAlg.mathVec

def mathVecTest : IO Unit :=
  open mathVec in do
    let v1 := tabulate 5 (λ i => 3.0)
    IO.eprintln (s! "{v1.get 0}")
    
