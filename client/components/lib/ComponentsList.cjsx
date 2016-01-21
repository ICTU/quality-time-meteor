{ Paper, List, ListItem, Avatar, Styles } = mui
{ Colors } = Styles

paperStyle =
  width:300
h3Style =
  backgroundColor: 'silver'
  padding: 10
  fontWeight: 300
  margin: 0
listStyle =
  padding: 0

statusColor = (status) ->
  switch status
    when 'ok'   then Colors.green400
    when 'nok'  then  Colors.red500
    else Colors.lightBlue500

@ComponentsList = React.createClass

  openDialog: (id) -> =>
    @refs[id].open()

  renderListItems: ->
    @props.measurements.map (measurement) =>
      avatarStyle =
        fontSize: 14
        backgroundColor: statusColor measurement.status.value
      passedUnitTestsAvatar = <Avatar style={avatarStyle}>{measurement.value}</Avatar>
      <ListItem key={measurement._id}
        primaryText={measurement.ofMetric}
        leftAvatar={passedUnitTestsAvatar}
        onTouchTap={@openDialog measurement._id}
      />

  x: ->
    @props.measurements.map (measurement) ->
      <DslHtmlView ref={measurement._id} key={measurement._id} ast={JSON.parse measurement.calculation} />

  render: ->

    <Paper style={paperStyle}>
      <h3 style={h3Style}>Referendum Applicatie</h3>
      <List style={listStyle}>
        {@renderListItems()}
      </List>
      {@x()}
    </Paper>


# <ListItem primaryText="PassedUnitTests" leftAvatar={passedUnitTestsAvatar} />
# <ListItem primaryText="TotalUnitTests" leftAvatar={totalUnitTestsAvatar} />
