Meteor.startup ->
  MetricTypes.remove {}

  MetricTypes.register = (impl) ->
    # register the metric type with the system
    MetricTypes.upsert {name: impl.name}, impl

    # insert default constant values
    constants = global[impl.name].prototype.constants or {}
    for constant in Object.keys constants
      unless MetricTypesConstants.findOne(name: constant, metric: impl.name)
        MetricTypesConstants.insert
          name: constant
          metric: impl.name
          value: "#{constants[constant]}"

    console.log "MetricType registered: #{impl.name}"
