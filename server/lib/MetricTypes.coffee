Meteor.startup ->
  MetricTypes.remove {}

  MetricTypes.register = (name, impl) ->
      MetricTypes.upsert {name: name},
        $set:
          _.extend {name: name}, impl
      console.log "MetricType registered: #{name}"
