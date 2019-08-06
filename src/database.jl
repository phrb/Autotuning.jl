"""
$(TYPEDSIGNATURES)

Creates an `IndexedTable` using a [`Configuration`](@ref).
"""
function table(configuration::Configuration)
    table((; NamedTuple{
        Tuple(collect(keys(configuration.parameters)))
    }(
        collect([v.current_value] for v in values(configuration.parameters))
    )...,
           NamedTuple{
               Tuple(keys(configuration.measurement))
           }(
               [[v] for v in values(configuration.measurement)]
           )...))
end

"""
$(TYPEDSIGNATURES)

Pushes a new [`Configuration`](@ref) to an `IndexedTable`.
"""
function push!(target_table::IndexedTable,
               configuration::Configuration)
    push!(rows(target_table), convert(NamedTuple, configuration))
end
