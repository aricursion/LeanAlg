import Lake
open System Lake DSL


package LeanAlg {
  -- customize layout
  --srcDir := "LeanAlg"
  --libRoots := #[`mathVec, `mathMatrix]
  -- specify the lib as an additional target
  moreLibTargets := #["./build/lib/libleanffi.so"]
  moreLinkArgs := #["-L", "./third_party/OpenBLASLib/lib", 
                    "-lopenblas", 
                    "-Wl,-R./third_party/OpenBLASLib/lib"]

  precompileModules := true
  packagesDir := "third_party"
}

--lean_lib LeanAlg {
  --precompileModules := true
--}

@[defaultTarget] lean_exe test {
  root := `Main
}

def pkgDir := __dir__
def cSrcDir := pkgDir / "c"
def cBuildDir := pkgDir / _package.buildDir / "c"
def libBuildDir := pkgDir / _package.buildDir / "lib"

def oTarget (filename : String) : FileTarget :=
  let oFile := cBuildDir / s!"{filename}.o"
  let srcTarget := inputFileTarget <| cSrcDir / s!"{filename}.c"
  fileTargetWithDep oFile srcTarget fun srcFile => do
    compileO oFile srcFile #["-I", "third_party/OpenBLASLib/include", "-fPIC",
                             "-I", (← getLeanIncludeDir).toString]
                             --"-L", "./third_party/OpenBLASLib/lib",
                             --"-fuse-ld=lld"]

--def cLibTarget (pkgDir : FilePath) : FileTarget :=
--  let libFile := pkgDir / buildDir / cDir / "libffi.a"
--  staticLibTarget libFile #[ffiOTarget]

extern_lib cLib :=
  let libFile := libBuildDir / nameToStaticLib "leanffi"
  staticLibTarget libFile #[oTarget "./utils/utils", oTarget "mathVec_ffi", oTarget "mathMatrix_ffi"]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
