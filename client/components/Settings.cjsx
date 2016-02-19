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

  open: ->
    @setState open: true

  handlePageUpdate: (e, value) ->
    @setState page: value

  render: ->
    actions = [
      <FlatButton
        label='Done'
        primary={true}
        disabled={false}
        style={color:'#3C80F6'}
        onTouchTap={@handleClose}
      />
    ]

    <Dialog
        title='Settings'
        actions={actions}
        modal={false}
        open={@state.open}
        onRequestClose={@handleClose}
      >
        <Divider />
        <div style={display:'flex'}>
          <SelectableList style={width:'25%'} valueLink={{value: @state.page, requestChange: @handlePageUpdate}}>
            <ListItem value={<MetricTargetValuesPage />}
              primaryText={<T>metric.targetValues</T>}
            />
          </SelectableList>
          <div style={width:'75%'}>
            {if @state.page then @state.page}
          </div>
        </div>
      </Dialog>

MetricTargetValuesPage = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    constants: MetricTypesConstants.find({}, sort: {metric: 1, name: 1}).fetch()

  render: ->
    <List>
      {for constant in @data.constants
        <MetricTargetValueEditor key={constant._id} constant={constant} />
      }
    </List>

MetricTargetValueEditor = React.createClass

  getInitialState: -> @props.constant

  onChange: (e) ->
    @setState value: e.target.value
    MetricTypesConstants.update @state._id, $set: value: e.target.value

  render: ->
    <TextField
      fullWidth={true}
      floatingLabelText="#{@state.metric}.#{@state.name}"
      value={@state.value}
      onChange={@onChange}
    />
