# LeanAlg
LeanAlg is a work in progress linear algebra library for Lean4. The goal is to
write many common linear algebra functions with custom C bindings in order
to improve performance, without affecting ease of proofs.

I'm always looking for feedback so please leave an issue or a PR 
(or just DM me on Discord xoers#2718)

# Setting Up OpenBlas
This library uses OpenBlas for optimized computation. It seemed silly to include
an entire library in this repository, so instead, I've provided an `openBLAS-setup.sh`
script

# Acknowledgments
Thank you so much to the Lean zulip for putting up with my constant questions,
and thanks to James for the inspiration to work on this for funsies :D

