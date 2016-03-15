@AcceptAsTechnicalDebt =
  acceptAsTechnicalDebt: (measurement) ->
    subject = Subjects.findOne name: measurement.forSubject
    metric = _.findWhere subject.metrics, name: measurement.ofMetric

    constantKeys = Object.keys(@constants)
    throw new Error "AcceptAsTechnicalDebt mixin allows for at most one constant" if constantKeys.length > 1
    constantName = constantKeys[0]
    metric.acceptedTechnicalDebt = {} unless metric.acceptedTechnicalDebt
    metric.acceptedTechnicalDebt[constantName] = measurement.value

    Subjects.update subject._id, subject

  clearTechnicalDebt: (measurement) ->
    Subjects.update
      name: measurement.forSubject
      "metrics.name": measurement.ofMetric
    ,
      $unset:
        "metrics.$.acceptedTechnicalDebt": 1
