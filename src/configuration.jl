"""
$(TYPEDEF)

A configuration parameter with value of type `T` and valid range in an `Array{T,
1}`. Should be created as part of a [`Configuration`](@ref).

$(TYPEDFIELDS)
"""
struct Parameter{T}
    current_value::T
    values::Array{T, 1}
end

"""
$(TYPEDEF)

$(TYPEDFIELDS)
"""
struct Configuration
    parameters::Dict{String, Parameter}
end


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

"""
$(TYPEDSIGNATURES)

Receives a [`Parameter`](@ref) `p` and  returns a new [`Parameter`](@ref) with a
new `current_value`.   The new value  is chosen  uniformly at random  within the
valid range of `values` of `p`, on an interval with radius `magnitude`, centered
at the `current_value` of `p`.

The argument `magnitude` is a `Float64`  between `0.0` and `1.0` that represents
how  much `p`  will  be  perturbed, proportionally  to  its  valid interval.  No
perturbation  is achieved  with  `magnitude =  0.0`, and  `magnitude  = 1.0`  is
equivalent to a uniform random sample within the valid range of `values` of `p`.
"""
function perturb(p::Parameter{Float64}, magnitude::Float64)
    radius::Float64 = abs(magnitude * (p.values[2] - p.values[1]))
    Parameter(rand() *
              (min(p.values[2], p.current_value + radius) -
               max(p.values[1], p.current_value - radius)) +
              max(p.values[1], p.current_value - radius),
              p.values)
end

"""
$(TYPEDSIGNATURES)
"""
function perturb(p::Union{Parameter{PowerOfTwo},
                          Parameter{Int64},
                          Parameter{String}
                          },
                 magnitude::Float64)
    current_index::Int64 = findfirst(x -> x == p.current_value, p.values)
    radius::Int64 = round(Int64, magnitude * size(p.values, 1))

    Parameter(rand(p.values[max(1, current_index - radius):min(size(p.values, 1),
                                                               current_index + radius)]),

              p.values)
end
