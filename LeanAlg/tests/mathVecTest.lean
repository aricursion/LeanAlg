import LeanAlg.mathVec

def mathVecTest : IO Unit :=
  open mathVec in do
    let mut tests_passed := true

    let v1 := from_array #[1, 2, 3]
    if ((v1.get (1 : Fin 3)).toUInt8 ≠ 2) then
      IO.eprintln (s! "New Vec not settings values properly")
      tests_passed := false

    let dot := dot_product v1 v1
    if dot.toUInt8 ≠ 14 then
      IO.eprintln (s! "Dot product not working")
      tests_passed := false


    let v2 := mathVec.set v1 (1 : Fin 3) 5
    if (v1.get (1 : Fin 3)).toUInt8 = (v2.get (1 : Fin 3)).toUInt8 then
      IO.eprintln (s! "Not updating values properly")
      IO.eprintln (s! "val in original vec {v1.get (1 : Fin 3)}")
      IO.eprintln (s! "val in new vec {v2.get (1 : Fin 3)}")
      tests_passed := false

    if tests_passed = true then
      IO.eprintln (s!"All mathVec tests passed!")
