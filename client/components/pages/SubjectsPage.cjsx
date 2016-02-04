
@SubjectsPage = React.createClass
  displayName: 'SubjectsPage'

  customEditComponent: (valueLink) ->
    <SubjectSourceLinkEditor valueLink={valueLink} />

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

SubjectSourceLinkEditor = React.createClass
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

      {@state.sources.map (s, idx) ->
        handleChange = (idx) -> (obj) =>
          @state.sources[idx] = _.extend @state.sources[idx], obj
          @props.valueLink.requestChange @state

        <SourceConfigEditor key={s.id} config={s} onChange={handleChange idx}/>
      }

    </div>

SourceConfigEditor = React.createClass
  displayName: 'SourceConfigEditor'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    source: Sources.findOne _id: @props.config.id

  handleChange: (e) ->
    console.log 'change', e.target.value, e
    @props.handleChange {jobName: e.target.value}

  render: ->
    <span>
      <h3>{@data.source.name}</h3>
      <EditField field='jobName' onChange={@handleChange}/>
    </span>
