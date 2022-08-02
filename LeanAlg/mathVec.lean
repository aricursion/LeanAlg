import LeanAlg.genVec

structure mathVec (m : Nat) where
  data : Fin m -> Float

instance : Inhabited (mathVec m) where
  default : mathVec m:= ⟨λ _ => 0⟩  

@[extern "mathVec_initialize"]
opaque mathVec_initializer : IO Unit

builtin_initialize mathVec_initializer

namespace mathVec
-- Supporting functions for Lean
-- definition of dot product
def foldl (f : α → β → α) (z : α) : {m : Nat} → (v : genVec m β) → α  
  | 0, _   => z
  | Nat.succ _, v => foldl f (f z (v.data 0)) ⟨v.data ∘ Fin.succ⟩

def zip (v w : @&mathVec m) : genVec m (Float × Float) 
  := ⟨λ i => (v.data i, w.data i)⟩ 

def to_genVec (v : mathVec m) : genVec m Float
  := ⟨v.data⟩

@[extern "mathVec_new"]
def new (m : @&Nat) (x : @&Float) : mathVec m 
  := ⟨λ _ => x⟩  

@[extern "mathVec_tabulate"]
def tabulate (m : @&Nat) (f : @&Fin m -> Float) : mathVec m
  := ⟨λ i => f i⟩  

@[extern "mathVec_eqv"]
def isEqv : {m : Nat} → (v w : @&mathVec m) → Bool
  | 0, _, _ => True
  | Nat.succ _, v, w => (v.data 0 == w.data 0) ∧ 
                        isEqv ⟨v.data ∘ Fin.succ⟩ ⟨w.data ∘ Fin.succ⟩ 

instance : BEq (mathVec m)
  := ⟨λ M1 M2 => isEqv M1 M2⟩

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
def dot_product : {m : Nat} → (v w : @&mathVec m) → Float
  | 0, _, _ => 1
  | Nat.succ _, v, w => (v.data 0 * w.data 0) + 
                        dot_product ⟨v.data ∘ Fin.succ⟩ ⟨w.data ∘ Fin.succ⟩ 

def toString (v : mathVec m) : String :=
  Id.run do
    let mut out := ""
    for h : i in [:m] do
      let i' := Fin.mk i h.upper
      out := out ++ (v.get i').toString ++ " "

    return out
