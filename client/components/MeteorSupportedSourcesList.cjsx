@MeteorSupportedSourcesList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: SupportedSources.find().fetch()


  render: ->
    <SupportedSourcesList sources={@data.sources} />
