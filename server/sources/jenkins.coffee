@Jenkins = class Jenkins
  constructor: (@source, @subject) ->
    @config = _.extend @source, @subject.jenkins
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

testSources = [
    name: 'Referendum Applicatie Jenkins'
    description: "RApp Jenkins CI"
    url: 'http://www.jenkins.kiesraad.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    class: 'Jenkins'
  ,
    name: 'Inspectieviews ISZW Jenkins'
    description: "Inspectieviews ISZW Jenkins CI"
    url: 'http://www.jenkins.inspectieviews.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    class: 'Jenkins'
  ,
    name: 'Metrics Kwaliteit Jenkins'
    description: "Metrics Kwaliteit Jenkins CI"
    url: 'http://jenkins.isf.org:8080/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    class: 'Jenkins'
]

Meteor.startup ->
  if Sources.find().count() is 0
    Sources.register source for source in testSources

  # Sources.register 'Sonar',
  #   description: 'A static code analysis tool'
  #   img: 'https://upload.wikimedia.org/wikipedia/commons/e/e6/Sonarqube-48x200.png'
  #   class: Jenkins
  #
  # Sources.register 'Jira',
  #   description: 'A collaborative workflow and task planning environment'
  #   img: 'https://jira.atlassian.com/images/atlassian-jira-logo-large.png'
  #   class: Jenkins



#console.log 'jenkins properties', Object.keys Jenkins.prototype
