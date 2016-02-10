{ ListItem } = mui

@MeasurementListItem = React.createClass

  onTouchTap: (e) ->
    if @props.onTouchTap
      @props.onTouchTap e, @props.measurement

  render: ->
    secondaryText = (m) ->
      if m and not m.value then i18n('measurement.failing')
      else if not m then i18n('measurement.noMeasurements')

    m = @props.measurement
    avatar = <MeasurementAvatar measurement={m} />
    <ListItem
      primaryText={@props.title}
      secondaryText={secondaryText m}
      leftAvatar={avatar}
      disabled={not m?}
      onTouchTap={@onTouchTap}
    />
