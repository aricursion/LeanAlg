-- This code exists strictly for Lean definitions
-- It should (hopefully) never be used in Lean functions
-- That are not manually written in C

structure genVec (m : Nat) (α : Type u) where
  data : Fin m -> α 

namespace genVec

def new (m : Nat) (x : α) : genVec m α 
  := ⟨λ m => x⟩  


def tabulate (m : Nat) (f : Fin m -> α) : genVec m α 
  := ⟨λ i => f i⟩  

def from_array [Inhabited α] (a : Array α) : (genVec a.size α )
  := ⟨λ i => a[i]⟩  

def get (v : genVec m α) (i : Fin m) : α 
  := v.data i

def set (v : genVec m α) (i : Fin m) (x : α) : genVec m α 
  := ⟨λ z => if z = i then x else v.data z⟩

-- Supporting functions for Lean
-- definition of dot product
def foldl (f : α → β → α) (z : α) : {m : Nat} → (v : genVec m β) → α  
  | 0, v   => z
  | m+1, v => foldl f (f z (v.data 0)) ⟨v.data ∘ Fin.succ⟩

def zip (v : genVec m α) (w : genVec m β) : genVec m (α × β) 
  := ⟨λ i => (v.data i, w.data i)⟩

def VecEqv [BEq α] (v w : genVec n α) : Bool :=
  let zipped := v.zip w 
  genVec.foldl (λ b (vi, wi) => b ∧ (vi == wi)) True zipped

