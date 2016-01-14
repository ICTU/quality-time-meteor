
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

Meteor.startup ->
  Sources.register 'Jenkins',
    description: 'A Continuous Build Server'
    img: 'https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png'
    class: Jenkins

  Sources.register 'Sonar',
    description: 'A static code analysis tool'
    img: 'https://upload.wikimedia.org/wikipedia/commons/e/e6/Sonarqube-48x200.png'
    class: Jenkins

  Sources.register 'Jira',
    description: 'A collaborative workflow and task planning environment'
    img: 'https://jira.atlassian.com/images/atlassian-jira-logo-large.png'
    class: Jenkins



#console.log 'jenkins properties', Object.keys Jenkins.prototype
