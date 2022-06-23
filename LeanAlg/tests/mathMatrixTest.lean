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

    let m1 := new 2 2 3
    let m1 := m1.set 0 0 5
    let m1 := m1.set 0 1 1

    let m2 := new 2 2 4
    let m2 := m2.set 1 0 6
    let m3 := m1.multiply m2

    IO.eprintln (s! " check: {m3.get 1 1}")
