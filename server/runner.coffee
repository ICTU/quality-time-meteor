supportedProperties   = (metric, ds)          -> (property for property in metric.properties when ds[property])
dsFullySupportsMetric = (metric, ds)          -> metric.properties.length <= supportedProperties(metric, ds).length
supportedDataSources  = (metric, datasources) -> (ds for ds in datasources when dsFullySupportsMetric metric, ds)

propertyWrapper = (config, propertyFunc) -> -> propertyFunc config
measure = (metric, datasources...) ->
  invocationParams = {}
  for ds in datasources
    props = supportedProperties metric, ds
    for prop in props
      invocationParams[prop] = ds[prop].bind(ds)

  if Object.keys(invocationParams).length is metric.properties.length
    metric.measure invocationParams
  else
    throw new Error 'Unable to satisfy all property dependencies for metric, missing: ' + _.difference(metric.properties, Object.keys(invocationParams))


RApp = ->
  name: 'Referendum Applicatie'
  jenkins:
    url: 'http://www.jenkins.kiesraad.ictu/'
    jobName: 'RApp'

measureAndRegister = (metricClass, sourceClass, subject) ->
  calculation = (measure new metricClass(), new sourceClass(subject) )()
  Measurements.insert
    timestamp: new Date()
    forSubject: subject.name
    ofMetric: metricClass.name
    value: Q.exec calculation
    calculation: Q.toJSON calculation

runner = ->
  subject = RApp()

  measureAndRegister TotalUnitTests, Jenkins, subject
  measureAndRegister PassedUnitTests, Jenkins, subject

Meteor.startup ->
  runner()
  # Meteor.setInterval runner, 3000
