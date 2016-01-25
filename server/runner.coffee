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


RApp = ->
  name: 'Referendum Applicatie'
  jenkins:
    # url: 'http://www.jenkins.kiesraad.ictu/'
    jobName: 'RApp'

InspectISZW = ->
  name: 'Inspectieviews ISZW'
  jenkins:
    url: 'http://www.jenkins.inspectieviews.ictu/'
    jobName: 'av-ingestion-iszw'

InspectBedrijvenWsdl = ->
  name: 'Inspectieviews Bedrijven WSDL'
  jenkins:
    url: 'http://www.jenkins.inspectieviews.ictu/'
    jobName: 'iv-bedrijven-wsdl'

MetricsKwaliteit = ->
  name: 'Metrics Kwaliteit'
  jenkins:
    url: 'http://jenkins.isf.org:8080/'
    jobName: 'metrics-kwaliteit'

measureAndRegister = (metricClass, source, subject) ->
  m = (measure new metricClass(), new global[source.class](source, subject))
  calculation = m.calc()
  jsonCalc = Q.toJSON calculation
  query =
    forSubject: subject.name, ofMetric: metricClass.name, calculation: jsonCalc

  if measurement = Measurements.findOne(query, sort: lastMeasured: -1)
    measurement.lastMeasured = new Date()
    Measurements.update {_id: measurement._id}, measurement
  else
    console.log m.status
    measurementObject =
      firstMeasured: new Date()
      lastMeasured: new Date()
      forSubject: subject.name
      ofMetric: metricClass.name
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

  # Sources.find().map (sourceType) ->

  subject = RApp()
  source = Sources.findOne name: 'Referendum Applicatie Jenkins'
  measureAndRegister TotalUnitTests, source, subject
  measureAndRegister PassedUnitTests, source, subject

  subject = InspectISZW()
  source = Sources.findOne name: 'Inspectieviews Jenkins'
  measureAndRegister TotalUnitTests, source, subject
  measureAndRegister PassedUnitTests, source, subject

  subject = InspectBedrijvenWsdl()
  source = Sources.findOne name: 'Inspectieviews Jenkins'
  measureAndRegister TotalUnitTests, source, subject
  measureAndRegister PassedUnitTests, source, subject

  subject = MetricsKwaliteit()
  source = Sources.findOne name: 'Metrics Kwaliteit Jenkins'
  measureAndRegister TotalUnitTests, source, subject
  measureAndRegister PassedUnitTests, source, subject

Meteor.startup ->
  if process.env.DEV
    runner()
    Meteor.setInterval runner, 30000
  else console.log 'Runner disabled'
