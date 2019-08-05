"""
$(TYPEDEF)

$(TYPEDFIELDS)

An alias of `NamedTuple`.
"""
const Measurement = NamedTuple{
                                 (
                                     :measured, :cost, :technique, :date
                                 ),
                                 Tuple{
                                     Bool, Float64, String, DateTime
                                 }
                             }

function configuration_table(configuration::Configuration,
                             measurement::Measurement)
    table((; NamedTuple{
        Tuple(
            collect(
                keys(
                    configuration.parameters
                )
            )
        )
    }(
        collect(
            [v.current_value] for v in values(configuration.parameters)
        )
    )...,
           NamedTuple{
               Tuple(
                   keys(measurement)
               )
           }(
               [[v] for v in values(measurement)]
           )...
           )
          )
end

function configuration_table(configuration::Configuration)
    configuration_table(configuration,
                        (
                            measured = false,
                            cost = NaN,
                            technique = "initialization",
                            date = now(),
                        ))
end

function push_measurement(target_table::IndexedTable,
                          configuration::Configuration,
                          measurement::Measurement)
    append!(rows(target_table), rows(configuration_table(configuration, measurement)))
end
