"""
$(TYPEDEF)

Stores an immutable *configuration parameter*,  its *current value* of type `T`,
and its *valid range* in an `Array{T, 1}`.

$(TYPEDFIELDS)
"""
struct Parameter{T}
    current_value::T
    values::Array{T, 1}
end
