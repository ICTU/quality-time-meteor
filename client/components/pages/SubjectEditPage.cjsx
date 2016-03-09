{ Dialog , FlatButton } = mui

@SubjectEditPage = React.createClass
  displayName: 'SubjectEditPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    subject: Subjects.findOne _id: @props.id or {}
    allSources: Sources.find({}, sort: name: 1).fetch()
    allMetricTypes: MetricTypes.find({}, sort: name: 1).fetch()

  onSave: (doc) ->
    Subjects.upsert _id: doc._id, doc
    FlowRouter.go '/subjects'

  onCancel: ->
    FlowRouter.go '/subjects'

  render: ->
    <xSubjectEditPage
      subject={@data.subject}
      allSources={@data.allSources}
      allMetricTypes={@data.allMetricTypes}
      save={@onSave}
      cancel={@onCancel}
    />

xSubjectEditPage = React.createClass
  displayName: 'xSubjectEditPage'
  mixins: [LinkedStateMixin]

  getInitialState: ->
    subject: @props.subject

  onSaveTapped: ->
    @props.save @state.subject

  render: ->
    title = if @state.subject.name then "Edit #{@state.subject.name}" else 'Add subject'

    <Page title={title} style={padding:10}>
      <Card>
        <EditForm
          ref='editForm'
          showActionButtons={false}
          schema={Schema.Subjects}
          doc={@state.subject}
        />
      </Card>

      <PageElement title='Sources'
        rightElement={
          <SubjectItemsMenu
            valueLink={@linkState('subject')}
            field='sources'
            transform={(item) -> id: item._id}
            items={@props.allSources}
          />
        }
      >
        <SubjectSourceEditor valueLink={@linkState('subject')} />
      </PageElement>

      <PageElement title='Metrics'
        rightElement={
          <SubjectItemsMenu valueLink={@linkState('subject')}
            field='metrics'
            transform={(item) -> sourceId: item._id, name: item.name}
            items={@props.allMetricTypes}
          />
        }
      >

        <SubjectMetricEditor valueLink={@linkState('subject')} />
      </PageElement>

      <div style={textAlign: 'right', paddingTop: 20}>
        <FlatButton
          label="Cancel"
          secondary={true}
          onTouchTap={@props.cancel} />
        <FlatButton
          label="Save"
          primary={true}
          keyboardFocused={true}
          onTouchTap={@onSaveTapped} />
      </div>
    </Page>

SubjectItemsMenu = React.createClass
  displayName: 'SubjectItemsMenu'

  getInitialState: ->
    doc = @props.valueLink?.value or {}
    doc.sources = [] unless doc.sources # null safeguard
    doc

  onTouchTap: (item) -> =>
    @state[@props.field].push @props.transform item
    @props.valueLink.requestChange @state

  render: ->
    <IconMenu
      anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
      targetOrigin={{horizontal: 'right', vertical: 'top'}}
      iconButtonElement={<IconButton touch={true}><ContentAdd /></IconButton>}>
      {@props.items.map (items) =>
        <MenuItem key={items._id} value={items._id} primaryText={items.name} onTouchTap={@onTouchTap items}/>
      }
    </IconMenu>

SubjectSourceEditor = React.createClass
  displayName: 'SubjectSourceEditor'

  getInitialState: ->
    doc = @props.valueLink?.value or {}
    doc.sources = [] unless doc.sources # null safeguard
    doc

  render: ->
    <div>
      {@state.sources.map (s, idx) =>
        handleChange = (idx) => (obj) =>
          @state.sources[idx] = _.extend @state.sources[idx], obj
          @props.valueLink.requestChange @state

        <SourceConfigEditor key={s.id} config={s} onChange={handleChange idx}/>
      }
    </div>

SubjectMetricEditor = React.createClass
  displayName: 'SubjectMetricEditor'

  getInitialState: ->
    doc = @props.valueLink?.value or {}
    doc.metrics = [] unless doc.metrics # null safeguard
    doc

  render: ->
    <div>
      {@state.metrics.map (m, idx) =>
        handleChange = (idx) => (obj) =>
          @state.metrics[idx] = _.extend @state.metrics[idx], obj
          @props.valueLink.requestChange @state

        <ExpandableCard key=idx leftAvatar={<Avatar>{m.name[0]}</Avatar>} headerElement={<h4 style={margin: 10}>{m.name}</h4>}>
          <MetricConfigEditor key={m.name} config={m} onChange={handleChange idx} sourceIds={@state.sources.map (s) -> s.id}/>
        </ExpandableCard>
      }
    </div>

SourceConfigEditor = React.createClass
  displayName: 'SourceConfigEditor'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    source: Sources.findOne _id: @props.config.id

  getInitialState: ->
    @props.config

  handleChange: (field) -> (e) =>
    fields = {}; fields[field] = e.target.value
    @setState fields
    @props.onChange fields

  render: ->
    sourceType = SourceTypes.findOne(name: @data.source.type)
    <ExpandableCard leftAvatar={<Avatar src={@data.source.icon} />} headerElement={<h4 style={margin: 10}>{@data.source.name} ({@data.source.type})</h4>}>
      <div className="source-fields">
        {for field in sourceType.fields
          <EditField key=field field=field value={@state[field]} onChange={@handleChange(field)}/>
        }
      </div>
    </ExpandableCard>

MetricConfigEditor = React.createClass
  displayName: 'MetricConfigEditor'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    metricType: MetricTypes.findOne name: @props.config.name
    sources: Sources.find({_id: $in: @props.sourceIds}).fetch()
    constants: MetricTypesConstants.find(metric: @props.config.name).fetch()

  getInitialState: ->
    @props.config

  handleSourceChange: (e, id, value) ->
    @setState sourceId: value
    @props.onChange {sourceId: value}

  handleConstantChange: (constant) -> (e) =>
    if e.target.value isnt ''
      constants = @state.constants or {}
      constants[constant] = e.target.value
      @state.constants = constants
    else
      delete @state.constants[constant]
    @props.onChange @state

  render: ->
    <div style={display: 'flex'}>
      <div style={width:'50%'}>
        <h5>Configuration</h5>
        <SelectField value={@state.sourceId} onChange={@handleSourceChange} floatingLabelText='Select a source'>
          {@data.sources.map (s) ->
            <MenuItem key={s._id} value={s._id} primaryText={s.name}/>
          }
        </SelectField>
      </div>
      <div style={width:'50%'}>
        <h5>Override defaults</h5>
        {for constant in @data.constants
          <span>
            <TextField
              key=constant.name
              floatingLabelText="#{constant.name}, default: #{constant.value}"
              value={@state.constants?[constant.name]}
              onChange={@handleConstantChange(constant.name)}
            />
          </span>
        }
      </div>
    </div>
