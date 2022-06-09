structure cVec where
  data : Array Float

instance : Inhabited (cVec) where
  default : cVec := ⟨#[]⟩  

namespace cVec

#check cVec.mk

#check cVec.data
unsafe def externMk : Array Float -> cVec
  := panic! "Can't actually do this"
attribute [implementedBy externMk] cVec.mk

unsafe def externData : cVec -> Array Float
  := panic! "Can't actually do this"
attribute [implementedBy externData] cVec.data

@[extern "cVec_new"]
def new (m : @&Nat) (x : @&Float) : cVec 
  := ⟨mkArray m x⟩  

def from_arr (a : @&Array Float) : cVec
  := ⟨a⟩  

@[extern "cVec_get_val"]
def get (v : @&cVec) (i : @&Nat) : Float 
  := v.data[i]

@[extern "cVec_dot_prod"]
def dot_product (v w : @&cVec) : Float
  := Array.foldr (λ (x, y) z => z + x*y) 0 (Array.zip v.data w.data)

