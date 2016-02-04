{ Dialog , FlatButton } = mui

@SourcesPage = React.createClass
  displayName: 'SourcesPage'
  mixins: [ReactMeteorData]

  getInitialState: ->
    actionHover: false

  onDocumentSelected: (doc) ->
    FlowRouter.go "/sources/edit/#{doc._id}"

  onTouchTap: ->
    FlowRouter.go "/sources/new"

  getMeteorData: ->
    sources: Sources.find({}, sort: name: 1).fetch()

  onMouseEnter: ->
    @setState actionHover: true
  onMouseLeave: ->
    @setState actionHover: false

  render: ->
    fields = ['name', 'description']

    <span>
      <Page title='All sources'>
        <CollectionList documents={@data.sources} fields={fields} onDocumentSelected={@onDocumentSelected} />
      </Page>
      <FloatingActionButton
        style={position:'fixed', right:40, bottom: 40}
        backgroundColor='#483D8B'
        onMouseEnter={@onMouseEnter}
        onMouseLeave={@onMouseLeave}
        onTouchTap={@onTouchTap}>
        {if @state.actionHover
          <HardwareDeviceHub />
        else
          <ContentAdd />
        }
      </FloatingActionButton>
    </span>
