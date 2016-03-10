@AcceptAsTechnicalDebt =
  acceptAsTechnicalDebt: (measurement) ->
    subject = Subjects.findOne name: measurement.forSubject
    metric = _.findWhere subject.metrics, name: measurement.ofMetric

    constantName = Object.keys(@constants)[0]
    metric.acceptedTechnicalDebt = {} unless metric.acceptedTechnicalDebt
    metric.acceptedTechnicalDebt[constantName] = measurement.value

    Subjects.update subject._id, subject
