# SGPGA.jl: Space Groups in Projective Geometric Algebra

This package uses [projective geometric algebra](https://www.projectivegeometricalgebra.org) to
describe space groups and their associated operations in a unified framework. Say goodbye to
augmented matrices - flectors, rotors and motors are where it's at!

## About projective geometric algebra

[Geometric algebra](https://www.bivector.net/) is the application of Clifford algebras to practical
problems. They arise naturally in the description of many phenomena, such as electromagnetism. It
provides a framework to naturally describe rotations in a computationally efficient way: complex
numbers and quaternions arise naturally in Clifford algebras as a class of objects known as
*rotors*, and generalize to higher dimensions.

[Projective geometric algebra](https://www.projectivegeometricalgebra.org) (PGA) uses a Clifford
algebra with an extra projective dimension that allows for the modeling of objects like points, 
lines, and planes. It's particularly useful for working with computer graphics. In this framework,
rotations involving the projective dimension become *motors*, which describe translations.

Considering that space groups consist of point isometries (rotations, reflections, 
rotoreflections), translations, and combinations of them (screw axes and glide planes), PGA is a
very natural choice for a framework to describe space groups.
