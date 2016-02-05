{ ListItem } = mui

@MeasurementListItem = React.createClass

  onTouchTap: (e) ->
    if @props.onTouchTap
      @props.onTouchTap e, @props.measurement

  render: ->
    m = @props.measurement
    avatar = <MeasurementAvatar measurement={m} />
    <ListItem
      primaryText={@props.title}
      secondaryText={'No measurements!' unless m}
      leftAvatar={avatar}
      onTouchTap={@onTouchTap}
    />
