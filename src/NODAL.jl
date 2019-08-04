module NODAL

using Test
using DocStringExtensions
using JuliaDB

export Parameter, Configuration, PowerOfTwo, perturb

include("configuration.jl")
include("database.jl")

end
