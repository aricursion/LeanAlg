structure mathMatrix (m n : Nat) where
  data : Fin m -> Fin n -> Float

instance : Inhabited (mathMatrix m n) where
  default : mathMatrix m n := ⟨λ _ _ => 0⟩  

@[extern "mathMatrix_initialize"] private constant mathMatrix_initializer : IO Unit

builtin_initialize mathMatrix_initializer
namespace mathMatrix

@[extern "mathMatrix_new"]
def new (m n : @&Nat) (x : @&Float) : mathMatrix m n
  := ⟨λ m => λ n => x⟩  

-- for whatever reason, when accessing you need to
-- explicitly type the index such as (3 : Fin a.size)
-- row, col
--@[extern "mathMatrix_from_array"]
def from_array (a : @&Array (Array Float)) : (mathMatrix (a.size) (a[0].size))
  := ⟨λ i => λ j => a[i][j]⟩  

@[extern "mathMatrix_get_val"]
def get (M : @&mathMatrix m n) (i : @&Fin m) (j : @& Fin n) : Float 
  := M.data i j

--@[extern "mathMatrix_set_val"]
def set (M : @&mathMatrix m n) (i : @&Fin m) (j : @&Fin n) (x : @&Float) : mathMatrix m n
  := ⟨λ a b => if a = i ∧ j = b then x else M.data a b⟩


