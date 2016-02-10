{ Avatar, Styles: { Colors }} = mui

statusColor = (status) ->
  switch status
    when 'ok'   then Colors.green400
    when 'nok'  then  Colors.red500
    else Colors.lightBlue500

@MeasurementAvatar = React.createClass

  getDefaultProps: ->
    style: {}

  render: ->
    m = @props.measurement
    if m and m.value
      avatarStyle = _.extend @props.style,
        fontSize: 14
        backgroundColor: statusColor m.status.value

      <Avatar style={avatarStyle}>{m.value}</Avatar>
    else if m
      <Avatar backgroundColor={Colors.red500} {...@props}
        icon={<ActionReportProblem className="material-icons" />} />
    else
      <Avatar backgroundColor={Colors.deepOrange400} {...@props}
        icon={<ActionReportProblem className="material-icons" />} />
