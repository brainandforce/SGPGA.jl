#---Types and structs for multivectors-------------------------------------------------------------#

"""
    AbstractMultivector{Cl,T}

Supertype for all representations of a multivector in the Clifford algebra `Cl` with coefficients
of type `T`.

The ordering of basis elements is always given with the elements squaring to positive values first,
then elements that square to negative values, then elements that square to zero, corresponding to
the ordering of the type parameters of `CliffordAlgebra{P,N,Z}`.

All subtypes of `AbstractMultivector` must implement addition, subtraction, multiplication, 
division (left and right - the algebra is not commutative), natural exponentiation, the inverse,
and the reverse.
"""
abstract type AbstractMultivector{Cl<:CliffordAlgebra,T<:Number}
end

"""
    Multivector{Cl,T,L}

A dense representation of a multivector in the Clifford algebra `Cl` with coefficients of type `T`,
which necessarily has `L` elements. As `L` can be computed from the algebra, most constructor
invocations only require the first two parameters, or possibly only one if the input element type 
can be determined.
"""
struct Multivector{Cl,T,L} <: AbstractMultivector{Cl,T}
    coeff::NTuple{L,T}
    function Multivector{Cl}(x) where Cl
        L = 2^dimension(Cl)
        @assert length(x) == L string(
            "Incorrect number of components: multivectors of ", Cl, " have ", L, "components."
        )
        return new{Cl,T,L}(x)
    end
end

"""
    EvenMultivector{Cl,T,L}

A dense representation of a multivector in the even subalgebra of the Clifford algebra `Cl` with
coefficients of type `T`.

These multivectors are often used to describe rotors and motors.
"""
struct EvenMultivector{Cl,T,L} <: AbstractMultivector{Cl,T}
    coeff::NTuple{L,T}
    function EvenMultivector{Cl}(x) where Cl
        L = 2^(dimension(Cl) - 1)
        @assert length(x) == L string(
            "Incorrect number of components: multivectors of ", Cl, " have ", L, "components."
        )
        return new{Cl,T,L}(x)
    end
end

"""
    KVector{Cl,K,T,L}

A k-vector of the Clifford algebra `Cl` with coefficients of type `T`. This is a multivector whose
only nonzero basis components are those of grade `K`.
"""
struct KVector{Cl,K,T,L} <: AbstractMultivector{Cl,T}
    coeff::NTuple{L,T}
    function KVector{Cl,K}(x) where {Cl,K}
        L = binomial(dimension(Cl), K)
        @assert length(x) == L string(
            "Incorrect number of components: ", K, "-vectors of ", Cl, " have ", L, "components."
        )
        return new{Cl,K,T,L}(x)
    end
end

#---Type promotion rules--------------------------------------------------------------------------#

import Base.promote_rule

# General promotion to multivectors
function promote_rule(
    ::Type{<:Multivector{Cl,T1}},
    ::Type{<:AbstractMultivector{Cl,T2}}
) where {Cl,T1,T2}
    return Multivector{Cl,promote_type(T1,T2)}
end

function promote_rule(
    ::Type{<:EvenMultivector{Cl,T1}},
    ::Type{<:KVector{Cl,K,T2}}
) where {Cl,K,T1,T2}
    #= TODO:
    This isn't type stable, but in principle, we want the type to be `EvenMultivector` if
    the KVector grade is even.
    if iseven(K)
        return EvenMultivector{Cl,promote_type(T1,T2),2^(dimension(Cl) - 1)}
    else
        return Multivector{Cl,promote_type(T1,T2),2^dimension(Cl)}
    end
    =#
    return Multivector{Cl,promote_type(T1,T2),2^dimension(Cl)}
end

function Base.promote_rule(
    ::Type{<:KVector{Cl,K1,T1}},
    ::Type{<:KVector{Cl,K2,T2}}
) where {Cl,K1,K2,T1,T2}
    #= TODO:
    This isn't type stable, but in principle, we want the type to be `EvenMultivector` if
    the grades of both KVectors are even.
    if iseven(K1) && iseven(K2)
        return EvenMultivector{Cl,promote_type(T1,T2),2^(dimension(Cl) - 1)}
    else
        return Multivector{Cl,promote_type(T1,T2),2^dimension(Cl)}
    end
    =#
    return Multivector{Cl,promote_type(T1,T2),2^dimension(Cl)}
end

#---Type conversion rules-------------------------------------------------------------------------#

# Conversions to complex numbers
# These are either elements of Cl₀,₁,₀(ℝ) or the even subalgebra of Cl₂,₀,₀(ℝ)
function Base.convert(
    ::Type{Complex},
    m::Multivector{CliffordAlgebra{0,1,0}})
    return complex(m.coeff...)
end

# Even subalgebras of the Clifford algebras of 2D space
function Base.convert(
    ::Type{Complex},
    m::EvenMultivector{Cl}
) where Cl<:Union{CliffordAlgebra{2,0,0},CliffordAlgebra{0,2,0}}
    return complex(m.coeff...)
end

# Conversions from complex numbers
function Base.convert(
    ::Type{Multivector{CliffordAlgebra{0,1,0}}},
    z::Complex
)
    return Multivector{CliffordAlgebra{0,1,0}}((real(z), imag(z)))
end

function Base.convert(
    ::Type{EvenMultivector{Cl}},
    z::Complex
) where Cl<:Union{CliffordAlgebra{2,0,0},CliffordAlgebra{0,2,0}}
    return Multivector{Cl}((real(z), imag(z)))
end

#---Addition of multivectors----------------------------------------------------------------------#

# TODO: there might be a nicer way of constructing these methods
# Best case: types are the same
function Base.:+(m1::AM, m2::AM) where {AM<:AbstractMultivector{Cl} where {Cl<:CliffordAlgebra}}
    return AM(m1.coeff .+ m2.coeff)
end

function Base.:+(m1::KVector{Cl,K}, m2::KVector{Cl,K}) where {Cl,K}
    return KVector{Cl,K}(m1.coeff .+ m2.coeff)
end

#---Geometric products----------------------------------------------------------------------------#

#---Special multivector operations----------------------------------------------------------------#

function reverse(m::AbstractMultivector)
    
end

#---Other methods---------------------------------------------------------------------------------#

"""
    basis_element(Cl::CliffordAlgebra{P,N,Z}, m::Multivector, ind::Integer) -> Symbol

Returns the symbol corresponding to the basis element at a specific index.
"""
function basis_element(Cl::CliffordAlgebra{P,N,Z}, m::Multivector, ind::Integer) where {P,N,Z}
    
end
