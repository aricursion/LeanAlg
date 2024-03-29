import LeanAlg.mathVec
import LeanAlg.genVec
import LeanAlg.utils.FloatUtils

structure mathMatrix (m n : Nat) where
  data : Fin m -> Fin n -> Float

instance : Inhabited (mathMatrix m n) where
  default : mathMatrix m n := ⟨λ _ _ => 0⟩  

@[extern "mathMatrix_isEqv"]
def isEqv (M1 M2 : @&mathMatrix m n) : Bool :=
  let M1' : genVec m (Fin n -> Float) := ⟨M1.data⟩ 
  let M2' : genVec m (Fin n -> Float) := ⟨M2.data⟩
  genVec.foldl (λ b (M1i, M2i) => b ∧ (genVec.VecEqv ⟨M1i⟩ ⟨M2i⟩)) True (genVec.zip M1' M2')

instance : BEq (mathMatrix m n)
  := ⟨λ M1 M2 => isEqv M1 M2⟩

@[extern "mathMatrix_initialize"]
opaque mathMatrix_initializer : IO Unit

builtin_initialize mathMatrix_initializer

namespace mathMatrix

@[extern "mathMatrix_new"]
def new (m n : @&Nat) (x : @&Float) : mathMatrix m n
  := ⟨λ _ => λ _ => x⟩  

-- for whatever reason, when accessing you need to
-- explicitly type the index such as (3 : Fin a.size)
-- row, col
--@[extern "mathMatrix_from_array"]
--def from_array (a : @&Array (Array Float)) : (mathMatrix (a.size) (a[0].size))
--  := ⟨λ i => λ j => a[i][j]⟩  

@[extern "mathMatrix_get_val"]
def get (M : @&mathMatrix m n) (i : @&Fin m) (j : @& Fin n) : Float 
  := M.data i j

@[extern "mathMatrix_set_val"]
def set (M : @&mathMatrix m n) (i : @&Fin m) (j : @&Fin n) (x : @&Float) : mathMatrix m n
  := ⟨λ a b => if a = i ∧ j = b then x else M.data a b⟩

@[extern "mathMatrix_transpose"]
def transpose (M : @&mathMatrix m n) : mathMatrix n m
  := ⟨λ i j => M.data j i⟩

@[extern "mathMatrix_getCol"]
def getCol (M : @& mathMatrix m n) (j : Fin n) : mathVec m 
  := ⟨λ i => M.data i j⟩

@[extern "mathMatrix_getRow"]
def getRow (M : @& mathMatrix m n) (i : Fin m) : mathVec n
  := ⟨λ j => M.data i j⟩ 

def toString (M : mathMatrix m n) : String :=
  Id.run do
    let mut out := ""
    for h : i in [:m] do
      let i' := Fin.mk i h.upper
      out := out ++ (M.getRow i').toString ++ "\n"
    return out

instance : ToString (mathMatrix m n)
  := ⟨λ M => M.toString⟩

@[extern "mathMatrix_mul_MM"]
def multiply_MM (M : @& mathMatrix m n) (M' : @&mathMatrix n k) : mathMatrix m k
  := ⟨λ i j => mathVec.dot_product (getRow M i) (getCol M' j)⟩ 

@[extern "mathMatrix_mul_Mv"]
def multiply_Mv (M : @&mathMatrix m n) (v : @&mathVec n) : mathVec m 
  := ⟨λ i => mathVec.dot_product v (M.getRow i)⟩ 

--@[extern "mathmatrix_mul_vM"]
def multiply_vM (v : @&mathVec m) (M: @&mathMatrix m n) : mathVec n 
  := ⟨λ i => mathVec.dot_product v (M.getCol i)⟩ 

@[extern "mathMatrix_new_id"]
def id (n : Nat) : mathMatrix n n :=
  ⟨λ i j => if i = j then 1 else 0⟩ 

@[extern "mathMatrix_exp"]
def exp (M : mathMatrix n n) : (e : Nat) -> mathMatrix n n
| 0 => mathMatrix.id n
| Nat.succ m => M.multiply_MM (exp M m)
