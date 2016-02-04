
@SubjectsPage = React.createClass
  displayName: 'SubjectsPage'

  customEditComponent: (valueLink) ->
    console.log 'customEditComponent', valueLink
    <SubjectSourceEditor valueLink={valueLink} />

  render: ->
    fields = ['name']
    editFields = ['name', {'jenkins': ['jobName']}]

    <Page title='All subjects'>
      <MeteorCrudPage
        collection={Subjects}
        listFields={fields}
        editFields={editFields}
        itemName='Subject'
        customRenderer={@customEditComponent}
        />
    </Page>

SubjectSourceEditor = React.createClass
  displayName: 'SubjectSourceEditor'

  mixins: [ReactMeteorData]

  getInitialState: ->
    doc = @props.valueLink.value or {}
    doc.sources = [] unless doc.sources
    doc

  getMeteorData: ->
    allSources: Sources.find({}, sort: name: 1).fetch()

  onTouchTap: (source) -> =>
    @state.sources.push {id: source._id}
    @props.valueLink.requestChange @state

  render: (valueLink) ->
    console.log 'customEditComponent', valueLink
    <div>
      <Toolbar>
        <ToolbarGroup firstChild={true} float="left">
          <ToolbarTitle text="Sources" />
        </ToolbarGroup>
        <ToolbarGroup float="right">
          <IconMenu
            anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
            targetOrigin={{horizontal: 'right', vertical: 'top'}}
            iconButtonElement={<IconButton touch={true}><ContentAdd /></IconButton>}>
            {@data.allSources.map (source) =>
              <MenuItem key={source._id} value={source._id} primaryText={source.name} onTouchTap={@onTouchTap source}/>
            }
          </IconMenu>
        </ToolbarGroup>
      </Toolbar>
    </div>
