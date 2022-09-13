"""
    SymmetryOperation{D}
    SymOp{D}

A description of a symmetry operation that can be applied to a crystal.

The standard description of symmetry operations is that of an augmented matrix: a matrix that 
describes a rotation, reflection, or rotoinversion, and a translation vector that is absorbed into
the matrix.

The description of symmetry operations in projective geometric algebra uses a superspace with an 
extra projective dimension, the Clifford algebra with signature (`D`, 0, 1). Point operations can
be described with flectors, rotors, and their combinations, and translation operations can be 
described with motors, which are rotation operators involving a real dimension and the projected
dimension.
"""
struct SymmetryOperation{D}
    
end

const SymOp{D} = SymmetryOperation{D}

"""
    PointGroup{D}

A description of a point group. This consists of a `Vector{SymmetryOperation{D}}` containing all of
the symmetry operations of the group.

Point group operations *cannot* contain symmetry operations with a motor component, as this would
not hold a point fixed.
"""
struct PointGroup{D}
    ops::Vector{SymmetryOperation{D}}
end

"""
    WyckoffPosition{D}

A Wyckoff position of a space group, corresponding to a site that maintains some kind of symmetry.
Wyckoff positions can be described by k-vectors in the projective geometric algebra: 1-vectors are
points, 2-vectors are lines, 3-vectors are planes, etc.

Each position also has a point group that describes all of the associated symmetry operations, and
a name consisting of a letter and number.
"""
struct WyckoffPosition{D}
    
end
