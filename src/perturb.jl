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
function perturb(p::Parameter{PowerOfTwo}, magnitude::Float64)
    current_index::Int64 = findfirst(x -> Int64(x) == Int64(p.current_value),
                                     p.values)
    radius::Int64 = round(Int64, magnitude * size(p.values, 1))

    Parameter(rand(p.values[max(1,
                                current_index - radius):min(size(p.values, 1),
                                                            current_index + radius)]),

              p.values)
end
