using NODAL, CSV, JuliaDB

function sample_x_y(samples::Int,
                    magnitude_x::Float64,
                    magnitude_y::Float64)
    configuration = Configuration(Dict(:x => Parameter(0.5, [0.0, 1.0]),
                                       :y => Parameter(0.5, [0.0, 1.0])))

    sampled_data = table(configuration)
    magnitude = Dict(:x => magnitude_x,
                     :y => magnitude_y)

    for i = 2:samples
        configuration = perturb(configuration, magnitude)
        push!(sampled_data, configuration)
    end

    return sampled_data
end

function sample()
    samples = 10
    magnitudes = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

    sampled_data = sample_x_y(samples, magnitudes[1], magnitudes[1])
    sampled_data = pushcol(sampled_data,
                           (:mag_x => repeat([magnitudes[1]], samples),
                            :mag_y => repeat([magnitudes[1]], samples)))

    for magnitude in magnitudes[2:end]
        new_data = sample_x_y(samples, magnitude, magnitude)
        new_data = pushcol(new_data,
                           (:mag_x => repeat([magnitude], samples),
                            :mag_y => repeat([magnitude], samples)))

        append!(rows(sampled_data), rows(new_data))
    end

    new_data = sample_x_y(samples, magnitudes[1], magnitudes[end])
    new_data = pushcol(new_data,
                       (:mag_x => repeat([magnitudes[2]], samples),
                        :mag_y => repeat([magnitudes[end]], samples)))
    append!(rows(sampled_data), rows(new_data))

    new_data = sample_x_y(samples, magnitudes[end], magnitudes[1])
    new_data = pushcol(new_data,
                       (:mag_x => repeat([magnitudes[end]], samples),
                        :mag_y => repeat([magnitudes[2]], samples)))
    append!(rows(sampled_data), rows(new_data))

    CSV.write("sampled_data.csv", sampled_data)
end

sample()
