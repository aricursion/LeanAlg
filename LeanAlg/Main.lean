import Ffi

#check 1.0 < 1.0 ∧ 1.0 > 1.0

def main : IO Unit :=
  do
    let val := cVec.get (cVec.new 100 100) 99

    let dot := cVec.dot_product (cVec.new 3 5) (cVec.new 4 5)
    if dot >= 5 then
      IO.eprintln s!"works"
      IO.eprintln s!"{dot}"
