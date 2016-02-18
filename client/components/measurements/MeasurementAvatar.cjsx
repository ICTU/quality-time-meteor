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

    getStyle = (backgroundColor) =>
      _.extend @props.style,
        fontSize: 14
        boxShadow: "0 0px 3px #{backgroundColor}, 0 1px 4px rgba(0, 0, 0, 0.24)"
        backgroundColor: backgroundColor

    if m and not Utils.isEmpty(m.value)
      <Avatar style={getStyle statusColor m.status.value}>{m.value}</Avatar>
    else if m
      <Avatar style={getStyle Colors.red500} {...@props}
        icon={<ActionReportProblem className="material-icons" />} />
    else
      <Avatar style={getStyle Colors.deepOrange400} {...@props}
        icon={<ActionReportProblem className="material-icons" />} />
