@MeteorSourcesList = React.createClass
  displayName: 'MeteorSourcesList'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: Sources.find().fetch()

  render: ->
    <SourcesList sources={@data.sources} />
