"""
$(TYPEDEF)

An  alias  of  `NamedTuple`,  stores   information  on  requested  and  measured
[`Configuration`](@ref).

$(TYPEDFIELDS)
"""
const Measurement = NamedTuple{
    (
        :measured,
        :cost,
        :technique,
        :date_requested,
        :date_measured
    ),
    Tuple{
        Bool,
        Union{Float64, Missing},
        Union{String, Missing},
        Union{DateTime, Missing},
        Union{DateTime, Missing}
    }
}

Measurement() = (
    measured = false,
    cost = missing::Union{Float64, Missing},
    technique = missing::Union{String, Missing},
    date_requested = now()::Union{DateTime, Missing},
    date_measured = missing::Union{DateTime, Missing}
)

"""
$(TYPEDSIGNATURES)

Pushes a new [`Configuration`](@ref) to a `DataFrame`.
"""
function push!(target_table::DataFrame, c::Configuration)
    push!(
        target_table,
        merge(
            Measurement(),
            NamedTuple{keys(c)}(
                (p.current for p in c.parameters)
            )
        )
    )
end

"""
$(TYPEDSIGNATURES)

Creates a `DataFrame` using a [`Configuration`](@ref).
"""
function configuration_table(c::Configuration)
    push!(
        DataFrame(
            NamedTuple{
                (keys(c)..., fieldnames(Measurement)...)
            }(
                Array{T, 1}() for T in ((typeof(p.current) for p in values(c))...,
                                        fieldtypes(Measurement)...)
            )
        ),
        c
    )
end
