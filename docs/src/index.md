# SGPGA.jl: Space Groups in Projective Geometric Algebra

SGPGA.jl is a framework that allows users to work with space groups, commonly encountered in 
crystallography, by using the mathematical framework of 
[projective geometric algebra](https://www.projectivegeometricalgebra.org/).

Projective geometric algebra (PGA) is a Clifford algebra whose graded elements correspond to
familiar geometric objects, such as points, lines, and planes. This is accomplished by adding an
extra projective dimension - for instance, the 3D PGA consists of 4 total dimensions.
Mathematically, this corresponds to the Clifford algebra Cl(ℝ)₍₃,₀,₁₎ which has 3 dimensions with
a positive square and one with zero square.

To facilitate these computations, SGPGA.jl comes with its own built-in lightweight multivector
implementation.
