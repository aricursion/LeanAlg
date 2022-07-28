import Lake
open System Lake DSL

lean_lib LeanAlg

package LeanAlg {
  -- customize layout
  --srcDir := "LeanAlg"
  --libRoots := #[`mathVec, `mathMatrix]
  -- specify the lib as an additional target
  --moreLibTargets := #[cLibTarget __dir__]
  moreLinkArgs := #["-L", "./third_party/OpenBLASLib/lib", 
                    "-lopenblas", 
                    "-Wl,-R./third_party/OpenBLASLib/lib"]

  --precompileModules := true
  packagesDir := "third_party"
}

@[defaultTarget] lean_exe test {
  root := `Main
}

def pkgDir := __dir__
def cSrcDir := pkgDir / "c"
def cBuildDir := pkgDir / _package.buildDir / "c"

def ffiOTarget : FileTarget :=
  let oFile := cBuildDir / "bindings.o"
  let srcTarget := inputFileTarget <| cSrcDir / "bindings.c"
  fileTargetWithDep oFile srcTarget fun srcFile => do
    compileO oFile srcFile #["-I", (← getLeanIncludeDir).toString,
                             "-I", "third_party/OpenBLASLib/include"]

--def cLibTarget (pkgDir : FilePath) : FileTarget :=
--  let libFile := pkgDir / buildDir / cDir / "libffi.a"
--  staticLibTarget libFile #[ffiOTarget]

extern_lib cLib :=
  let libFile := cBuildDir / nameToStaticLib "leanffi"
  staticLibTarget libFile #[ffiOTarget]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
