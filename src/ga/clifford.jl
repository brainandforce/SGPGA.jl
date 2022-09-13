#---Singleton type for geometric algebras---------------------------------------------------------#

"""
    CliffordAlgebra{P,N,Z}

Describes a Clifford algebra with signature (`P`,`N`,`Z`).

Note that there is no specification of the field over which the algebra is constructed: for the
purposes of geometric algebra, it is assumed to be the real numbers, but complex Clifford algebras
may also be constructed. The field is specified in `AbstractMultivector{Cl,T}` and its subtypes.
"""
struct CliffordAlgebra{P,N,Z}
end

#---Special geometric algebras---------------------------------------------------------------------#

"""
    APS

The algebra of physical space, Cl(3,0,0).
"""
const APS = CliffordAlgebra{3,0,0}

"""
    STAplus

Spacetime algebra with a mostly positive signature (mathematician's convention), Cl(3,1,0).
"""
const STAplus = CliffordAlgebra{3,1,0}

"""
    STAminus

Spacetime algebra with a mostly negative signature (particle physicist's convention), Cl(1,3,0).
"""
const STAminus = CliffordAlgebra{1,3,0}

"""
    PGA3D

Projective geometric algebra of 2 dimensions and 1 projective dimension, Cl(3,0,1).
"""
const PGA2D = CliffordAlgebra{2,0,1}

"""
    PGA3D

Projective geometric algebra of 3 dimensions and 1 projective dimension, Cl(3,0,1).
"""
const PGA3D = CliffordAlgebra{3,0,1}

#---Methods for working with Clifford algebras----------------------------------------------------#

dimension(::Type{<:CliffordAlgebra{P,N,Z}}) where {P,N,Z} = (P + N + Z)

"""
    invert_signature(::Type{CliffordAlgebra{P,N,Z}}) -> CliffordAlgebra{N,P,Z}

Switches the positive and negative components of the signature of a Clifford algebra.
"""
invert_signature(::Type{CliffordAlgebra{P,N,Z}}) where {P,N,Z} = CliffordAlgebra{N,P,Z}

#---Coding of basis elements----------------------------------------------------------------------#

"""
    special_generator_names{::Type{CliffordAlgebra}}
        -> NTuple{dimension(CliffordAlgebra),Symbol}

Gets the generator names that are used by convention for specific geometric algebras. This is 
currently supported for complex numbers (Cl(0,1,0)), Cl(2,0,0), the algebra of physical space
(`APS`), and spacetime algebras (`STAplus` and `STAminus`).
"""
special_generator_names(::Type{CliffordAlgebra{0,1,0}}) = (:i)
special_generator_names(::Type{CliffordAlgebra{2,0,0}}) = (:x, :y)
special_generator_names(::Type{APS}) = (:x, :y, :z)
special_generator_names(::Type{Union{STAplus,STAminus}}) = (:x, :y, :z, :t)
