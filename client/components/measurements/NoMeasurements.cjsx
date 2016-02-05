{ ListItem } = mui

@NoMeasurements = React.createClass
  dislplayName: 'NoMeasurements'

  render: ->
    <ListItem
      primaryText={'There is no data available for this subject!'}
      leftAvatar={ <ExclamationIcon /> }
    />

ExclamationIcon = React.createClass
  dislplayName: 'ExclamationIcon'

  render: ->
    <Avatar backgroundColor={Colors.red500} {...@props}
      icon={<ActionAssignmentLate className="material-icons" />} />
