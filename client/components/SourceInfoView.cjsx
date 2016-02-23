@SourceInfoView = React.createClass

  render: ->

    collectSourceInfo = (qObject, collector) ->
      collectBinary = ({arg1, arg2}) ->
        collectSourceInfo arg1, collector
        collectSourceInfo arg2, collector
      collectUnary = ({arg}) ->
        collectSourceInfo arg
      collectIf = (node) ->
        collectSourceInfo node.expression, collector
        collectSourceInfo node.then, collector
        collectSourceInfo node.else, collector

      collectInfo = (node) ->
        if node.sourceInfo
          collector.push  node.sourceInfo.id

      node = qObject.node or qObject
      switch node.type
        when 'binaryOperation'  then collectBinary node
        when 'unaryOperation'   then collectUnary node
        when 'if'               then collectIf node
        when 'measurement'      then collectInfo node
        when 'no_measurement'   then collectInfo node

    sources = []
    collectSourceInfo @props.ast, sources

    sources = _.uniq sources

    if sources.length
      <span>
        <h3>Sources</h3>
        <ul>
        {for sourceId in sources
          <li key={sourceId}><SourceInfoItem id={sourceId} subject={@props.subject} /></li>
        }
        </ul>
      </span>
    else
      <span />

SourceInfoItem = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    Sources.findOne @props.id

  getUrl: (config) ->
    {url, type} = config
    switch type
      when 'Sonar'    then Url.resolve url, "/dashboard/index/#{config.resourceName}"
      when 'Jenkins'  then Url.resolve url, "/job/#{config.jobName}"
      else url

  render: ->
    subjectSourceConfig = _.findWhere @props.subject.sources, id: @props.id
    config = _.extend @data, subjectSourceConfig
    <span><a href={@getUrl config} target='_blank'>{config.name}</a></span>
