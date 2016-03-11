supportedProperties = (metric, ds) ->
  (property for property in metric.properties when ds[property])
dsFullySupportsMetric = (metric, ds) ->
  metric.properties.length <= supportedProperties(metric, ds).length
supportedDataSources = (metric, datasources) ->
  (ds for ds in datasources when dsFullySupportsMetric metric, ds)

propertyWrapper = (config, propertyFunc) -> -> propertyFunc config
measure = (metric, metricConstants, datasources...) ->
  propertyValues = {}
  for ds in datasources
    props = supportedProperties metric, ds
    for prop in props
      propertyValues[prop] = ds[prop].bind(ds)

  if Object.keys(propertyValues).length is metric.properties.length
    calc: metric.measure propertyValues
    status: if metric.status then (metric.status propertyValues, metricConstants) else null
  else
    throw new Error 'Unable to satisfy all property dependencies for metric, missing: ' + _.difference(metric.properties, Object.keys(propertyValues))

getMetricConstantDefaults = (metric) ->
  _.object (["#{constant.name}", constant.value] for constant in MetricTypesConstants.find(metric: metric.name).fetch())

measureAndRegister = (metricType, source, subjectSource, metric) ->
  metricConstantDefaults = getMetricConstantDefaults metricType
  metricConstants = {}
  for k, v of metricConstantDefaults
    metricConstants[k] =
      default: v
      override: metric.constants?[k]
      acceptedTechnicalDebt: metric.acceptedTechnicalDebt?[k]
      value: metric.acceptedTechnicalDebt?[k] or metric.constants?[k] or v
  m = (measure new global[metricType.name](), metricConstants, new global[source.type](source, subjectSource))
  calculation = m.calc()
  jsonCalc = Q.toJSON calculation
  jsonStatus = Q.toJSON m.status
  query =
    forSubject: subjectSource.name, ofMetric: metricType.name, calculation: jsonCalc, 'status.calculation': jsonStatus

  if measurement = Measurements.findOne(query, sort: lastMeasured: -1)
    measurement.lastMeasured = new Date()
    Measurements.update {_id: measurement._id}, measurement
  else
    measurementObject =
      firstMeasured: new Date()
      lastMeasured: new Date()
      forSubject: subjectSource.name
      ofMetric: metricType.name
      value: Q.exec calculation
      calculation: jsonCalc

    if m.status
      measurementObject.status =
        calculation: jsonStatus
        value: Q.exec m.status
    else
      measurementObject.status =
        value: 'unknown'

    Measurements.insert measurementObject

runner = ->
  console.log 'Running measurements'

  for subject in Subjects.find().fetch()
    console.log 'for subject', subject.name
    for metric in subject.metrics or []
      metricType = MetricTypes.findOne name: metric.name
      source = Sources.findOne _id: metric.sourceId
      if source
        console.log 'metric', metricType.name, ' with source', source.name
        subjectSources = _.filter subject.sources, (s) -> s.id is source._id
        if subjectSources.length > 0
          subjectSources[0].name = subject.name
          measureAndRegister metricType, source, subjectSources[0], metric
        else
          console.log 'No source configuration defined in subject'
      else
        console.log 'metric', metricType.name, ' has no source configured'
      console.log '----'
    console.log '=================='

Meteor.startup ->
  if process.env.ENABLE_RUNNER
    Meteor.defer runner
    Meteor.setInterval runner, 10000
  else console.log 'Runner disabled'
