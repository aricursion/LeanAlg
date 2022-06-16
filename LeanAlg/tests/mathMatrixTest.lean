import LeanAlg.mathMatrix

def mathMatrixTest : IO Unit :=
  open mathMatrix in do
    let mut tests_passed := true
    let m1 := new 5 5 3
    if (m1.get 3 3).toUInt8 ≠ 3 then
      IO.eprintln (s!"New matrix not setting values properly")
      tests_passed := false

    let m2 := m1.set 2 3 10
    if (m2.get 2 3).toUInt8 ≠ 10 then
      IO.eprintln (s!"Not setting values propery")
      tests_passed := false

    if (m1.get 2 3).toUInt8 = 10 then
      IO.eprintln (s!"pass by reference, want by value")
      tests_passed := false

    if (m2.transpose.get 3 2).toUInt8 != (m2.get 2 3).toUInt8 then
      IO.eprintln (s!"Transpose not working")
      tests_passed := false

    if tests_passed = true then
      IO.eprintln (s!"All mathMatrix tests passed!")
