using NODAL, CSV, JuliaDB, Distributions

function sample_x_y(samples::Int,
                    distribution_x::Distribution,
                    distribution_y::Distribution)

    configuration = Configuration((x = Parameter(0.5, [0.0, 1.0]),
                                   y = Parameter(0.5, [0.0, 1.0])))

    distribution = (x = distribution_x,
                    y = distribution_y)

    configuration = perturb(configuration, distribution)

    sampled_data = table(configuration)

    for i = 2:samples
        configuration = perturb(configuration, distribution)
        push!(sampled_data, configuration)
    end

    return sampled_data
end

function sample()
    samples = 1000
    distributions = [
        (
            x = Truncated(Normal(0.5, 0.08), 0.0, 1.0),
            y = Truncated(Normal(0.5, 0.08), 0.0, 1.0),
            name = "mu:0.5,sig:0.08"
        ),
        (
            x = Truncated(Normal(0.5, 0.13), 0.0, 1.0),
            y = Truncated(Normal(0.5, 0.13), 0.0, 1.0),
            name = "mu:0.5,sig:0.13"
        ),
        (
            x = Truncated(Normal(0.1, 0.08), 0.0, 1.0),
            y = Truncated(Normal(0.5, 0.13), 0.0, 1.0),
            name = "mu:(0.1,0.5),sig:(0.08,0.13)"
        ),
        (
            x = MixtureModel(
                [
                    Truncated(Normal(0.0, 0.08), 0.0, 0.4),
                    Truncated(Normal(1.0, 0.08), 0.6, 1.0)
                ]
            ),
            y = MixtureModel(
                [
                    Truncated(Normal(0.0, 0.08), 0.0, 0.4),
                    Truncated(Normal(1.0, 0.08), 0.6, 1.0)
                ]
            ),
            name = "mu:(0.0,1.0)*2,sig:(0.08)*2"
        )
    ]

    sampled_data = sample_x_y(samples, distributions[1][:x], distributions[1][:y])
    sampled_data = pushcol(sampled_data,
                           (:name => repeat([distributions[1][:name]], samples)))

    for distribution in distributions[2:end]
        new_data = sample_x_y(samples, distribution[:x], distribution[:y])
        new_data = pushcol(new_data,
                           (:name => repeat([distribution[:name]], samples)))

        append!(rows(sampled_data), rows(new_data))
    end

    new_data = sample_x_y(samples, distributions[1][:x], distributions[end][:y])
    new_data = pushcol(new_data,
                       (:name => repeat([distributions[1][:name] * "x"], samples)))

    append!(rows(sampled_data), rows(new_data))

    new_data = sample_x_y(samples, distributions[end][:x], distributions[1][:y])
    new_data = pushcol(new_data,
                       (:name => repeat([distributions[end][:name] * "x"], samples)))

    append!(rows(sampled_data), rows(new_data))

    CSV.write("sampled_data.csv", sampled_data)
end

sample()
