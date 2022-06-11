structure mathVec (m : Nat) where
  data : Fin m -> Float

instance : Inhabited (mathVec m) where
  default : mathVec m:= ⟨λ _ => 0⟩  

@[extern "mathVec_initialize"] private constant mathVec_initializer : IO Unit

builtin_initialize mathVec_initializer
namespace mathVec

@[extern "mathVec_new"]
def new (m : @&Nat) (x : @&Float) : mathVec m 
  := ⟨λ m => x⟩  

-- for whatever reason, when accessing you need to
-- explicitly type the index such as (3 : Fin a.size)
@[extern "mathVec_from_array"]
def from_array (a : @&Array Float) : (mathVec a.size)
  := ⟨λ i => a[i]⟩  

@[extern "mathVec_get_val"]
def get (v : @&mathVec m) (i : @&Fin m) : Float 
  := v.data i

@[extern "mathVec_set_val"]
def set (v : @&mathVec m) (i : @&Fin m) (x : @&Float) : mathVec m
  := ⟨λ z => if z = i then x else v.data z⟩

@[extern "mathVec_scalar_mult"]
def scalar_multiply (v : @&mathVec m) (s : @& Float) : mathVec m
  := ⟨λ i => s * v.data i⟩ 

