module NODAL

using DocStringExtensions

export Parameter, Configuration, PowerOfTwo, perturb

include("parameter.jl")
include("configuration.jl")
include("custom_types.jl")
include("perturb.jl")

end
