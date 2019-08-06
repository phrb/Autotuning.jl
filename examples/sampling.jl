using NODAL

configuration = Configuration(Dict(:x => Parameter(0.5, [0.0, 1.0]),
                                   :y => Parameter(0.5, [0.0, 1.0])))

sampled_data = table(configuration)
