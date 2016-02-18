class @Jenkins extends Source
  constructor: (@source, @subject) ->
    super @source, @subject

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

Meteor.startup ->
  SourceTypes.register
    name: 'Jenkins'
    description: 'Jenkins data source'
    fields: ['jobName']
