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
  jenkins:
    url: 'http://www.jenkins.kiesraad.ictu/'
    jobName: 'RApp'

class Jenkins
  constructor: (@config) ->
    result = @get_json @config.jenkins.url, @config.jenkins.jobName
    for action in result.json?.actions
      if 'failCount' of action
        @results =
          fail_count: action.failCount
          skip_count: action.skipCount
          total_count: action.totalCount
          test_results_found: true

  failedUnitTestsCount: -> @results.fail_count
  skippedUnitTestsCount: -> @results.skip_count
  totalUnitTestsCount: -> @results.total_count

  get_json: (jenkins_url, jenkins_job) ->
    try
      result = HTTP.get jenkins_url + 'job/' + jenkins_job + '/lastBuild/api/json?tree=actions[failCount,skipCount,totalCount]'
      {json: result.data, error_message: ''}
    catch e
      {json: null, error_message: e.message}


class FailedTests_Metric
  properties: ['failedUnitTestsCount']
  measure: ({failedUnitTestsCount}) ->
    value: failedUnitTestsCount()

class PercentageSkipped_Metric
  properties: ['totalUnitTestsCount', 'skippedUnitTestsCount']
  measure: ({totalUnitTestsCount, skippedUnitTestsCount}) ->
    percentageSkipped: (skippedUnitTestsCount() / totalUnitTestsCount()) * 100
    total: totalUnitTestsCount()
    skipped: skippedUnitTestsCount()


#dataSources = [JenkinsDS, SonarDS, JunitDS, HtmlTestReportDS]
# console.log 'DataSources supporting LOC_Metric', supportedDataSources(LOC_Metric, dataSources)
# console.log 'DataSources supporting UnitTestCoverage', supportedDataSources(UnitTestCoverage, dataSources)
# console.log 'DataSources supporting FailedTestsMetric', supportedDataSources(FailedTestsMetric, dataSources)
#
# console.log 'FailedTestsMetric',  (measure FailedTestsMetric, GameOfLifeApp(), JunitDS, SonarDS)

console.log 'FailedTests_Metric',         (measure new FailedTests_Metric(), new Jenkins(RApp()) )
console.log 'PercentageSkipped_Metric',   (measure new PercentageSkipped_Metric(), new Jenkins(RApp()) )

console.log '====================================='
