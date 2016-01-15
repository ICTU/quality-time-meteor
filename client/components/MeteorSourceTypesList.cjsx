@MeteorSourceTypesList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: SourceTypes.find().fetch()


  render: ->
    <SourceTypesList sources={@data.sources} />
