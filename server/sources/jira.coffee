Url = Meteor.npmRequire 'url'

class @Jira extends Source
  constructor: (@source, @subject) ->
    super @source, @subject
    @results = {}

    issues = @getResult @config.url, @config.jql
    @results['readyUserStories'] = _.reduce issues, ((memo, r) => memo + (r.fields?[@config.storyPointField] or 0)), 0

  getResult: (url, jql, startAt = 0) ->
    try
      x = Url.resolve url, "rest/api/2/search?maxResults=50&startAt=#{startAt}&jql=#{jql}&fields=#{@config.storyPointField}"
      result = HTTP.get x, auth: "#{@config.username}:#{@config.password}"
      issues = result.data.issues

      if result.data.startAt + 50 < result.data.total
        _.union issues, @getResult url, jql, startAt + 50
      else issues
    catch e
      error: e.message

  readyUserStories: -> @result 'readyUserStories'

Meteor.startup ->
  SourceTypes.register
    name: 'Jira'
    description: 'Jira issue tracker'
    icon: '/images/sources/jira_icon.png'
    fields: ['jql']
