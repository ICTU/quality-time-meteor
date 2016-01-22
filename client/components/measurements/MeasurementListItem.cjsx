{ ListItem } = mui

@MeasurementListItem = React.createClass

  onTouchTap: (e) ->
    if @props.onTouchTap
      @props.onTouchTap e, @props.measurement

  render: ->
    m = @props.measurement
    avatar = <MeasurementAvatar measurement={m} />
    <ListItem
      primaryText={m.ofMetric}
      leftAvatar={avatar}
      onTouchTap={@onTouchTap}
    />
