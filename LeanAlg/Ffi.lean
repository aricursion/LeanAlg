structure cVec where
  data : Array Float
  length: Nat

instance : Inhabited (cVec) where
  default : cVec := ⟨#[], 0⟩ 

namespace cVec

#check cVec.mk

#check cVec.data
unsafe def externMk : Array Float -> Nat -> cVec
  := panic! "Can't actually do this"
attribute [implementedBy externMk] cVec.mk


unsafe def externData : cVec -> Array Float
  := panic! "Can't actually do this"
attribute [implementedBy externData] cVec.data

@[extern "cVec_new"]
def new (x : @&Float) (m : @&Nat): cVec 
  := ⟨mkArray m x, m⟩ 

@[export cVec_to_arr]
def from_arr (a : @&Array Float) : cVec
  := ⟨a, 5⟩ 

@[extern "cVec_get_val"]
def get (v : @&cVec) (i : @&Nat) : Float 
  := v.data[i]


@[extern "cVec_dot_prod"]
def dot_product (v w : @&cVec) : Float
  := Array.foldr (λ (x, y) z => z + x*y) 0 (Array.zip v.data w.data)

