module Autotuning

using Test
using Dates
using DocStringExtensions
using DataFrames
using Random
using Distributions

import Base: getproperty, getindex, keys, values, pairs, push!

export Configuration, Parameter, PowerOfTwo, Measurement,
    perturb, configuration_table, getproperty, getindex,
    keys, values, pairs, push!

include("configuration.jl")
include("database.jl")

end
