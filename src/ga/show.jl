import Base.show

# Easy for unsigned integers - the hard part is fixing the signs
subscript_str(n::Integer) = String(Vector{Char}(string(n)) .+ 0x2050)

function show(io::IO, ::MIME"text/plain", ::Type{CliffordAlgebra{P,N,Z}}) where {P,N,Z}
    println(io, "Cl", join(string.((P,N,Z)), ','))
end
