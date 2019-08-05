module NODAL

using Test
using Dates
using DocStringExtensions
using JuliaDB

import Base.convert

export Parameter, Configuration, PowerOfTwo, Measurement,
    perturb, configuration_table, convert, push_measurement

include("configuration.jl")
include("database.jl")

end
