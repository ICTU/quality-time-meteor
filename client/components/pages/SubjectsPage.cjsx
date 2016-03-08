{ Dialog , FlatButton } = mui

@SubjectsPage = React.createClass
  displayName: 'SubjectsPage'
  mixins: [ReactMeteorData]

  getInitialState: ->
    actionHover: false

  onDocumentSelected: (doc) ->
    FlowRouter.go "/subjects/#{doc._id}/edit"

  onTouchTap: ->
    FlowRouter.go "/subjects/new"

  getMeteorData: ->
    subjects: Subjects.find({}, sort: name: 1).fetch()

  onMouseEnter: ->
    @setState actionHover: true
  onMouseLeave: ->
    @setState actionHover: false

  render: ->
    fields = ['name', 'description']

    <span>
      <Page title='All subjects'>
        <Card>
          <CollectionList documents={@data.subjects} fields={fields} onDocumentSelected={@onDocumentSelected} />
        </Card>
      </Page>
      <FloatingActionButton
        style={position:'fixed', right:40, bottom: 40}
        backgroundColor='#483D8B'
        onMouseEnter={@onMouseEnter}
        onMouseLeave={@onMouseLeave}
        onTouchTap={@onTouchTap}>
        {if @state.actionHover
          <ActionDescription />
        else
          <ContentAdd />
        }
      </FloatingActionButton>
    </span>
