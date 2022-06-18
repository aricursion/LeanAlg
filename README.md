# LeanAlg
LeanAlg is a work in progress linear algebra library for Lean4. The goal is to
write many common linear algebra functions with custom C bindings in order
to improve performance, without affecting ease of proofs.

Note: Much of [NumLean](https://github.com/arthurpaulino/NumLean) served
as an example for how to make the FFI work, so a good portion of the code
in my `ffi.c` file is from there.

# Setting Up OpenBlas
This library uses OpenBlas for optimized computation. It seemed silly to include
an entire library in this repository, so instead, I've provided an `openBLAS-setup.sh`
script
