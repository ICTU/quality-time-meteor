class @Sonar extends Source
  constructor: (@source, @subject) ->
    super @source, @subject
    @results = {}

    result = @get_json @config.url, @config.resourceName, ['ncloc', 'coverage', 'violations', 'complexity', 'tests', 'duplicated_lines_density']
    for msr in result?.json?.msr
      @results[msr.key] = msr.val
    if result.error
      @error = result.error

  get_json: (url, resource, metrics) ->
    try
      result = HTTP.get "#{url}api/resources?resource=#{resource}&metrics=#{metrics}"
      {json: result.data[0], error_message: ''}
    catch e
      {json: null, error: e.message}

  linesOfCode: -> @result('ncloc')
  duplication: -> @result('duplicated_lines_density')
  codeCoverage: -> @result('coverage')
  violations: -> @result('violations')
  complexity: -> @result('complexity')
  unitTests: -> @result('tests')

Meteor.startup ->
  SourceTypes.register
    name: 'Sonar'
    description: 'Sonar data source'
    icon: '/images/sources/sonar_icon.gif'
    fields: ['resourceName']
