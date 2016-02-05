@Jenkins = class Jenkins
  constructor: (@source, @subject) ->
    @config = _.extend @source, @subject
    result = @get_json @config.url, @config.jobName
    for action in result?.json?.actions or []
      if 'failCount' of action
        @results =
          fail_count: action.failCount
          skip_count: action.skipCount
          total_count: action.totalCount
          test_results_found: true

    unless @results
      @results =
        fail_count: 0
        skip_count: 0
        total_count: 0
        test_results_found: false

  get_json: (jenkins_url, jenkins_job) ->
    try
      result = HTTP.get jenkins_url + 'job/' + jenkins_job + '/lastBuild/api/json?tree=actions[failCount,skipCount,totalCount]'
      {json: result.data, error_message: ''}
    catch e
      {json: null, error_message: e.message}

  failedUnitTestsCount: -> Q.val('failCount', @results.fail_count)
  skippedUnitTestsCount: -> Q.val('skipCount', @results.skip_count)
  totalUnitTestsCount: -> Q.val('totalCount', @results.total_count)
  passedUnitTestsCount: ->
    @totalUnitTestsCount().subtract(@failedUnitTestsCount()).subtract(@skippedUnitTestsCount())
