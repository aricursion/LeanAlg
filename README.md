# LeanAlg
LeanAlg is a work in progress linear algebra library for Lean4. The goal is to
write many common linear algebra functions with custom C bindings in order
to improve performance, without affecting ease of proofs.

Note: Much of [NumLean](https://github.com/arthurpaulino/NumLean) served
as an example for how to make the FFI work, so a good portion of the code
in my `ffi.c` file is from there.
