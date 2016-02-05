{ Dialog , FlatButton } = mui

@SubjectEditPage = React.createClass
  displayName: 'SubjectEditPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    if @props.id
      Subjects.findOne _id: @props.id
    else {}

  onCancelTapped: ->
    FlowRouter.go '/subjects'

  onSaveTapped: ->
    @refs.editForm.save()
    FlowRouter.go '/subjects'
  onSave: (doc) ->
    Subjects.upsert _id: doc._id, doc
    @setState snackbarOpen: true

  customEditComponent: (valueLink) ->
    <SubjectSourceLinkEditor valueLink={valueLink} />

  render: ->
    editFields = ['name']
    title = if @props.id then "Edit #{@data.name}" else 'Add subject'

    <span>
      <Page title={title} style={padding:10}>
        <EditForm
          ref='editForm'
          onSave={@onSave}
          showActionButtons={false}
          fields={editFields}
          doc={@data}
          customRenderer={@customEditComponent} />
      </Page>

      <div style={textAlign: 'right', paddingTop: 20}>
        <FlatButton
          label="Cancel"
          secondary={true}
          onTouchTap={@onCancelTapped} />
        <FlatButton
          label="Save"
          primary={true}
          keyboardFocused={true}
          onTouchTap={@onSaveTapped} />
      </div>
    </span>


SubjectSourceLinkEditor = React.createClass
  displayName: 'SubjectSourceEditor'

  mixins: [ReactMeteorData]

  getInitialState: ->
    doc = @props.valueLink.value or {}
    doc.sources = [] unless doc.sources
    doc.metrics = [] unless doc.metrics
    doc

  getMeteorData: ->
    allSources: Sources.find({}, sort: name: 1).fetch()
    metricTypes: MetricTypes.find({}, sort: name: 1).fetch()

  onTouchTap: (source) -> =>
    @state.sources.push {id: source._id}
    @props.valueLink.requestChange @state

  onTouchTapMetricType: (metricType) -> =>
    @state.metrics.push {name: metricType.name}
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

      {@state.sources.map (s, idx) =>
        handleChange = (idx) => (obj) =>
          @state.sources[idx] = _.extend @state.sources[idx], obj
          @props.valueLink.requestChange @state

        <SourceConfigEditor key={s.id} config={s} onChange={handleChange idx}/>
      }

      <Toolbar>
        <ToolbarGroup firstChild={true} float="left">
          <ToolbarTitle text="Metrics" />
        </ToolbarGroup>
        <ToolbarGroup float="right">
          <IconMenu
            anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
            targetOrigin={{horizontal: 'right', vertical: 'top'}}
            iconButtonElement={<IconButton touch={true}><ContentAdd /></IconButton>}>
            {@data.metricTypes.map (metricType) =>
              <MenuItem key={metricType._id} value={metricType.name} primaryText={metricType.name} onTouchTap={@onTouchTapMetricType metricType}/>
            }
          </IconMenu>
        </ToolbarGroup>
      </Toolbar>

      {@state.metrics.map (m, idx) =>
        handleChange = (idx) => (obj) =>
          @state.metrics[idx] = _.extend @state.metrics[idx], obj
          @props.valueLink.requestChange @state

        <SourceMetricEditor key={m.name} config={m} onChange={handleChange idx} sourceIds={@state.sources.map (s) -> s.id}/>
      }

    </div>

SourceConfigEditor = React.createClass
  displayName: 'SourceConfigEditor'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    source: Sources.findOne _id: @props.config.id

  getInitialState: ->
    @props.config

  handleChange: (e) ->
    @setState jobName: e.target.value
    @props.onChange {jobName: e.target.value}

  render: ->
    <span>
      <h3>{@data.source.name}</h3>
      <EditField field='jobName' value={@state.jobName} onChange={@handleChange}/>
    </span>

SourceMetricEditor = React.createClass
  displayName: 'SourceMetricEditor'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    metricType: MetricTypes.findOne name: @props.config.name
    sources: Sources.find({_id: $in: @props.sourceIds}).fetch()

  getInitialState: ->
    @props.config

  handleChange: (e, id, value) ->
    @setState sourceId: value
    @props.onChange {sourceId: value}

  render: ->
    <span>
      <h3>{@data.metricType.name}</h3>
      <SelectField value={@state.sourceId} onChange={@handleChange} floatingLabelText='Select a source'>
        {@data.sources.map (s) ->
          <MenuItem key={s._id} value={s._id} primaryText={s.name}/>
        }
      </SelectField>
    </span>
  # <EditField field='jobName' value={@state.jobName} onChange={@handleChange}/>
