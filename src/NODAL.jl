module NODAL

using Test
using Dates
using DocStringExtensions
using JuliaDB

import Base.convert, JuliaDB.table, JuliaDB.push!

export Parameter, Configuration, PowerOfTwo, Measurement,
    perturb, table, convert, push!

include("configuration.jl")
include("database.jl")

end
