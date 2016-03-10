Meteor.methods
  sources: ->
    Sources.getAll()

  'Sources.upsert': (doc) ->
    Sources.upsert {_id: doc._id}, {$set: doc}

  'acceptTechnicalDebt': (measurement) ->
    (new global[measurement.ofMetric]).acceptAsTechnicalDebt measurement
