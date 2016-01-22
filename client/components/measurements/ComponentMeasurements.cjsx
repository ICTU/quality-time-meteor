{ Paper, List } = mui

paperStyle =
  width:300
  marginBottom: 10
  marginLeft: 5
  float: 'left'
h3Style =
  backgroundColor: 'silver'
  padding: 10
  fontWeight: 300
  margin: 0
listStyle =
  padding: 0

@ComponentMeasurements = React.createClass

  openDialog: (e, metric)->
    @refs[metric._id].open()

  renderListItems: ->
    @props.measurements.map (measurement) =>
      <MeasurementListItem
        key={measurement._id}
        measurement={measurement}
        onTouchTap={@openDialog} />

  renderDetailDialogs: ->
    @props.measurements.map (measurement) ->
      <DslHtmlView ref={measurement._id} key={measurement._id} ast={JSON.parse measurement.calculation}
      statusAst={JSON.parse measurement.status.calculation}/>

  render: ->

    <Paper style={paperStyle}>
      <h3 style={h3Style}>{@props.measurements[0].forSubject}</h3>
      <List style={listStyle}>
        {@renderListItems()}
      </List>
      {@renderDetailDialogs()}
    </Paper>
