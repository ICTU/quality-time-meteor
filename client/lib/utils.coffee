@Utils =
  capitalize: (text) ->
    [first, rest...] = text
    "#{first.toUpperCase()}#{rest.join('')}"

  isEmpty: (v) -> v is null or v is undefined

@T = _i18n.createComponent()
@i18n = (key, params) -> _i18n.__ key, params


@getsubjectMetricMeasurements = (subject) ->
  measurements = for metric in subject.metrics
    _.extend metric, (Measurements.findOne({forSubject: subject.name, ofMetric: metric.name}, {sort: lastMeasured: -1}) or {})
