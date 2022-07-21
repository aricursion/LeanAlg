import LeanAlg.genVec

structure mathVec (m : Nat) where
  data : Fin m -> Float

instance : Inhabited (mathVec m) where
  default : mathVec m:= ⟨λ _ => 0⟩  

@[extern "mathVec_initialize"] private constant mathVec_initializer : IO Unit

builtin_initialize mathVec_initializer
namespace mathVec
-- Supporting functions for Lean
-- definition of dot product
def foldl (f : α → β → α) (z : α) : {m : Nat} → (v : genVec m β) → α  
  | 0, v   => z
  | m+1, v => foldl f (f z (v.data 0)) ⟨v.data ∘ Fin.succ⟩

def zip (v w : @&mathVec m) : genVec m (Float × Float) 
  := ⟨λ i => (v.data i, w.data i)⟩ 

def to_genVec (v : mathVec m) : genVec m Float
  := ⟨v.data⟩

@[extern "mathVec_new"]
def new (m : @&Nat) (x : @&Float) : mathVec m 
  := ⟨λ m => x⟩  

@[extern "mathVec_tabulate"]
def tabulate (m : @&Nat) (f : @&Fin m -> Float) : mathVec m
  := ⟨λ i => f i⟩  

@[extern "mathVec_eqv"]
def mathVecEqv (v w : mathVec m)
  := genVec.VecEqv (v.to_genVec) (w.to_genVec)

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

@[extern "mathVec_add_vector"]
def add_vector (v w : @&mathVec m) : mathVec m 
  := ⟨λ i => v.data i + w.data i⟩

@[extern "mathVec_dot_prod"]
def dot_product(v w : @&mathVec m) : Float :=
  genVec.foldl (λ z (x, y) => z + (x * y)) 0 (genVec.zip (to_genVec v) (to_genVec w))

def toString (v : mathVec m) : String :=
  Id.run do
    let mut out := ""
    for h : i in [:m] do
      let i' := Fin.mk i h.upper
      out := out ++ (v.get i').toString ++ " "

    return out
