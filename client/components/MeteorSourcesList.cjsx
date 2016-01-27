@MeteorSourcesList = React.createClass
  displayName: 'MeteorSourcesList'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: Sources.find().fetch()

  render: ->
    <SourcesList {... @props} sources={@data.sources} />
