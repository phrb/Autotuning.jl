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

An alias of `NamedTuple`.

$(TYPEDFIELDS)
"""
const Measurement = NamedTuple{
    (:measured, :cost, :technique, :date_requested, :date_measured),
    Tuple{Bool, Float64, String, DateTime, DateTime}
}

Measurement() = (
    measured = false,
    cost = NaN,
    technique = "initialization",
    date_requested = now(),
    date_measured = now()
)

"""
$(TYPEDEF)

Stores   a  [`Parameter`](@ref)   `NamedTuple`   and  a   [`Measurement`](@ref).
Represents the  association of specific performance  parameters with performance
measurements.

$(TYPEDFIELDS)
"""
struct Configuration
    parameters::NamedTuple
    measurement::Measurement
end

Configuration(parameters::NamedTuple) = Configuration(parameters, Measurement())

convert(::Type{NamedTuple}, c::Configuration) = NamedTuple{Tuple(
    vcat([k for k in keys(c.parameters)],
         [m for m in keys(c.measurement)]))}(
             vcat([k.current_value for k in values(c.parameters)],
                  [m for m in values(c.measurement)]))

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

Perturbing  categorical  ou discrete  numerical  parameters  must be  done  with
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
function perturb(configuration::Configuration, distribution::NamedTuple)
    return Configuration(typeof(configuration.parameters)(
        k = perturb(v, distribution[k])
        for (k, v) in pairs(configuration.parameters)))
end
