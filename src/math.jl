module Multivectors

"""
    CliffordAlgebra{P,N,Z}

Describes a Clifford algebra with signature (`P`,`N`,`Z`) where P is the number of elements that
square to a positive value, `N` is the number of elements that square to a negative value, and `Z`
is the number of elements that square to zero.
"""
struct CliffordAlgebra{P,N,Z}
end

"""
    Multivector{Sig,Grades,T,L}

Describes a general multivector:
* The signature `Sig` is given by an NTuple{3,Int}, with the components consisting of the number of
elements with positive, negative, and zero squares, respectively.
* `T` is the data type of the numeric values comprising the multivector. In most cases, this is 
some subtype of `AbstractFloat`, but any subtype of `Number` is allowed.
"""
struct Multivector{Sig,T<:Number,Grades,L}
    data::NTuple{L,T}
end

function Multivector{Sig,T,Grades}(
    grades::AbstractVector{<:Integer}
    vs::Vararg{AbstractVector{T}}
) where {Sig,T}
    # Get the total number of dimensions
    dimtot = sum(Sig)
    # Get the total number of each type of elements
    elcount = @SVector [binomial(dimtot,n) for n in 0:dimtot]
    return Multivector{Sig,T,Grades,L}()
end

function Base.show(io::IO, ::MIME"text/plain", Multivector{Sig,T,Grades,L})
    println(io, "Multivector{", Sig, ", ", T, ", ", "} with grades")
end

end # module
