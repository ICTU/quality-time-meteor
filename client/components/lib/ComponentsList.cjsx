{ Paper, List, ListItem, Avatar } = mui

avatarStyle =
  fontSize: 14

paperStyle =
  width:300
h3Style =
  backgroundColor: 'silver'
  padding: 10
  fontWeight: 300
  margin: 0
listStyle =
  padding: 0

@ComponentsList = React.createClass

  renderListItems: ->
    @props.measurements.map (measurement) ->
      passedUnitTestsAvatar = <Avatar style={avatarStyle}>{measurement.value}</Avatar>
      <ListItem key={measurement._id} primaryText={measurement.ofMetric} leftAvatar={passedUnitTestsAvatar} />

  render: ->

    <Paper style={paperStyle}>
      <h3 style={h3Style}>Referendum Applicatie</h3>
      <List style={listStyle}>
        {@renderListItems()}
      </List>
    </Paper>


# <ListItem primaryText="PassedUnitTests" leftAvatar={passedUnitTestsAvatar} />
# <ListItem primaryText="TotalUnitTests" leftAvatar={totalUnitTestsAvatar} />
