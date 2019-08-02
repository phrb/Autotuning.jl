"""
$(TYPEDEF)

Primitive type to store powers of two. Conversion to `Int64` computes the actual
power.
"""
primitive type PowerOfTwo <: Integer 64 end

"""
$(TYPEDSIGNATURES)

Creates a  `PowerOfTwo` instance using  an `Int64`. Exponentiation  is performed
when converting back to `Int64`.
"""
PowerOfTwo(x::Int64) = reinterpret(PowerOfTwo, x)

Int64(x::PowerOfTwo) = 2 ^ reinterpret(Int64, x)

Base.show(io::IO, x::PowerOfTwo) = print(io, Int64(x))
