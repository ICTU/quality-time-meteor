class Source
  result: (property) ->
    sourceInfo = _.extend @getInfo(), {id: @config._id}
    if @error then sourceInfo.error = @error
    if @results?[property] isnt undefined
      Q.measurement property, @results[property], sourceInfo
    else Q.noMeasurement property, sourceInfo

@Jenkins = class Jenkins extends Source
  constructor: (@source, @subject) ->
    @config = _.extend @source, _.omit(@subject, 'id', 'name')
    result = @get_json @config.url, @config.jobName
    for action in result?.json?.actions or []
      if 'failCount' of action
        @results =
          fail_count: action.failCount
          skip_count: action.skipCount
          total_count: action.totalCount
          test_results_found: true
    if result.error
      @error = result.error

  getInfo: ->
    name: @config.name
    # url: @config.url
    # jobName: @config.jobName

  get_json: (jenkins_url, jenkins_job) ->
    try
      result = HTTP.get jenkins_url + 'job/' + jenkins_job + '/lastBuild/api/json?tree=actions[failCount,skipCount,totalCount]'
      {json: result.data, error_message: ''}
    catch e
      {json: null, error: e.message}

  failedUnitTestsCount: -> @result('fail_count')
  skippedUnitTestsCount: -> @result('skip_count')
  totalUnitTestsCount: -> @result('total_count')
  passedUnitTestsCount: ->
    @totalUnitTestsCount().subtract(@failedUnitTestsCount()).subtract(@skippedUnitTestsCount())
