import Lake
open System Lake DSL

def cDir : FilePath := "c"
def ffiSrc := cDir / "bindings.c"
def buildDir := defaultBuildDir


def compileOMod (oFile srcFile : FilePath)
(moreArgs : Array String := #[]) (compiler : FilePath := "cc") : BuildM PUnit := do
  createParentDirs oFile
  proc {
    cmd := compiler.toString
    args := #[ "-o", oFile.toString, srcFile.toString] ++ moreArgs
  }

def ffiOTarget (pkgDir : FilePath) : FileTarget :=
  let oFile := pkgDir / buildDir / cDir / "bindings.o"
  let srcTarget := inputFileTarget <| pkgDir / ffiSrc
  fileTargetWithDep oFile srcTarget fun srcFile => do
    compileO oFile srcFile #["-I", (← getLeanIncludeDir).toString]


def cLibTarget (pkgDir : FilePath) : FileTarget :=
  let libFile := pkgDir / buildDir / cDir / "libffi.a"
  staticLibTarget libFile #[ffiOTarget pkgDir]

package LeanAlg (pkgDir) (args) {
  -- customize layout
  --srcDir := "LeanAlg"
  --libRoots := #[`mathVec, `mathMatrix]
  -- specify the lib as an additional target
  moreLibTargets := #[cLibTarget pkgDir]
  moreLinkArgs := #["-L", "./third_party/OpenBLASLib/lib", 
                    "-lopenblas", 
                    "-Wl,-R./third_party/OpenBLASLib/lib"]
}
