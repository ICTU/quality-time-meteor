supportedProperties = (metric, ds) ->
  (property for property in metric.properties when ds[property])
dsFullySupportsMetric = (metric, ds) ->
  metric.properties.length <= supportedProperties(metric, ds).length
supportedDataSources = (metric, datasources) ->
  (ds for ds in datasources when dsFullySupportsMetric metric, ds)

propertyWrapper = (config, propertyFunc) -> -> propertyFunc config
measure = (metric, datasources...) ->
  invocationParams = {}
  for ds in datasources
    props = supportedProperties metric, ds
    for prop in props
      invocationParams[prop] = ds[prop].bind(ds)

  if Object.keys(invocationParams).length is metric.properties.length
    calc: metric.measure invocationParams
    status: if metric.status then (metric.status invocationParams) else null
  else
    throw new Error 'Unable to satisfy all property dependencies for metric, missing: ' + _.difference(metric.properties, Object.keys(invocationParams))

measureAndRegister = (metric, source, subject) ->
  m = (measure new global[metric.className](), new global[source.class](source, subject))
  calculation = m.calc()
  jsonCalc = Q.toJSON calculation
  query =
    forSubject: subject.name, ofMetric: metric.name, calculation: jsonCalc

  if measurement = Measurements.findOne(query, sort: lastMeasured: -1)
    measurement.lastMeasured = new Date()
    Measurements.update {_id: measurement._id}, measurement
  else
    console.log m.status
    measurementObject =
      firstMeasured: new Date()
      lastMeasured: new Date()
      forSubject: subject.name
      ofMetric: metric.name
      value: Q.exec calculation
      calculation: jsonCalc

    if m.status
      measurementObject.status =
        calculation: Q.toJSON m.status
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
      console.log 'metric', metricType.name, ' with source', source.name
      subjectSources = _.filter subject.sources, (s) -> s.id is source._id
      if subjectSources.length > 0
        subjectSources[0].name = subject.name
        measureAndRegister metricType, source, subjectSources[0]
      else
        console.log 'No source configuration defined in subject'
      console.log '----'
    console.log '=================='

Meteor.startup ->
  if process.env.DEV
    Meteor.defer runner
    Meteor.setInterval runner, 10000
  else console.log 'Runner disabled'
