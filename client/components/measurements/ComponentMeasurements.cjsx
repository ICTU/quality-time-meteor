{ Paper, List } = mui

styles =
  paper:
    width:300
    marginBottom: 10
    marginLeft: 5
    float: 'left'
  h3:
    backgroundColor: 'rgba(0, 0, 0, 0.16)'
    padding: 10
    fontWeight: 300
    margin: 0
  list:
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
    <Paper style={styles.paper}>
      <h3 style={styles.h3}>{@props.measurements[0].forSubject}</h3>
      <List style={styles.list}>
        {@renderListItems()}
      </List>
      {@renderDetailDialogs()}
    </Paper>
