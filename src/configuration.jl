"""
$(TYPEDEF)

Stores  a  `NamedTuple`  of  [`Parameter`](@ref).   Encapsulates  an  autotuning
problem definition.

$(TYPEDFIELDS)
"""
struct Configuration{names, T}
    parameters::NamedTuple{names, T}
end

getindex(c::Configuration, symbol::Symbol) = getindex(c.parameters, symbol)
keys(c::Configuration) = keys(c.parameters)
values(c::Configuration) = values(c.parameters)
pairs(c::Configuration) = pairs(c.parameters)

"""
$(TYPEDEF)

A  configuration  parameter  with value  of  type  `T`  and  valid range  in  an
`Array{T,1}`. Should be created as part of a [`Configuration`](@ref).

$(TYPEDFIELDS)
"""
struct Parameter{T}
    current::T
    values::Array{T, 1}
end

values(p::Parameter) = Tuple(p.values)
getindex(p::Parameter, index::Int64) = getindex(p.values, index)

"""
$(TYPEDEF)

Primitive type, `Integer` wrapper.
"""
primitive type PowerOfTwo <: Integer 64 end

"""
$(TYPEDSIGNATURES)

Creates a  `PowerOfTwo` instance using  an `Int64`.
"""
PowerOfTwo(x::Int64) = reinterpret(PowerOfTwo, 2 ^ x)

Int64(x::PowerOfTwo) = reinterpret(Int64, x)

Base.show(io::IO, x::PowerOfTwo) = print(io, Int64(x))

"""
$(TYPEDSIGNATURES)

Receives a [`Parameter`](@ref) `p` and  returns a new [`Parameter`](@ref) with a
new `current_value`.   The new value  is chosen from a `Distribution`.

The  caller must  create the  appropriate  distribution to  control valid  value
ranges and perturbation magnitude. For `Float64` parameters, `distribution` must
be a valid continuous distribution or a `MixtureModel`.
"""
function perturb(p::Parameter{Float64}, distribution::Distribution)
    return Parameter(rand(distribution), p.values)
end

"""
$(TYPEDSIGNATURES)

Perturbing  categorical  or discrete  numerical  parameters  must be  done  with
`Distributions.Categorical` distributions.
"""
function perturb(p::Union{Parameter{PowerOfTwo}, Parameter{Int64}, Parameter{String}},
                 distribution::Distribution)
    return Parameter(p.values[rand(distribution)], p.values)
end

"""
$(TYPEDSIGNATURES)

Perturbs a [`Configuration`](@ref) by calling  [`perturb`](@ref) for each of its
[`Parameter`](@ref)  with  the  distributions   specified  in  the  `NamedTuple`
`distributions`.
"""
function perturb(c::Configuration, distribution::NamedTuple)
    Configuration(NamedTuple{keys(c)}([perturb(v, distribution[k]) for (k, v) in pairs(c)]))
end
