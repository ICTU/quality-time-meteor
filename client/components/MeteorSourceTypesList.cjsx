@MeteorSourceTypesList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: SourceTypes.find().fetch()

  render: ->
    <div>SourceTypesList is not implemented yet</div>
    # <SourceTypesList sources={@data.sources} />
