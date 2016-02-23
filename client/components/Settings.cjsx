metricTargetValuesPage = 'metricTargetValues'

@Settings = React.createClass

  mixins: [LinkedStateMixin]

  getDefaultProps: ->
    open: false

  getInitialState: ->
    open: @props.open
    page: null

  handleClose: ->
    @setState open: false

  handleDone: ->
    if (p = @refs.page)?.save then p.save()
    @handleClose()

  open: ->
    @setState open: true

  handlePageUpdate: (e, value) ->
    @setState page: value

  renderMetricTargetValuesPage: ->
    <MetricTargetValuesPage ref='page' />

  render: ->
    actions = [
      <FlatButton
        label='Done'
        primary={true}
        disabled={false}
        style={color:'#3C80F6'}
        onTouchTap={@handleDone}
      />
    ]

    <Dialog

        title='Settings'
        actions={actions}
        modal={false}
        open={@state.open}
        onRequestClose={@handleClose}
        contentStyle={width:600}
      >
        <Divider />
        <div style={display:'flex', minHeight:450}>
          <SelectableList style={width:'30%'} valueLink={{value: @state.page, requestChange: @handlePageUpdate}}>
            <ListItem value='renderMetricTargetValuesPage'
              primaryText={<T>metric.targetValues</T>}
            />
          </SelectableList>
          <div style={width:'70%', paddingLeft: 10}>
            {if @state.page then @[@state.page]()}
          </div>
        </div>
      </Dialog>

MetricTargetValuesPage = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    constants: MetricTypesConstants.find({}, sort: {metric: 1, name: 1}).fetch()

  save: ->
    component.save() for ref, component of @refs


  render: ->
    <List>
      {for constant in @data.constants
        <MetricTargetValueEditor ref={constant._id} key={constant._id} constant={constant} />
      }
    </List>

MetricTargetValueEditor = React.createClass

  getInitialState: -> @props.constant

  onChange: (e) ->
    @setState value: e.target.value

  save: ->
    MetricTypesConstants.update @state._id, $set: value: @state.value

  render: ->
    <TextField
      fullWidth={true}
      floatingLabelText="#{@state.metric}.#{@state.name}"
      value={@state.value}
      onChange={@onChange}
    />
