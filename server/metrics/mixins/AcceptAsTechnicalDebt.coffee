@AcceptAsTechnicalDebt =
  acceptAsTechnicalDebt: (measurement) ->
    subject = Subjects.findOne name: measurement.forSubject
    metric = _.findWhere subject.metrics, name: measurement.ofMetric

    console.log 'metric', metric
    console.log @constants
