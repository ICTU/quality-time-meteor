{ Styles: { Colors }} = mui

styles =
  atd:
    backgroundColor: Colors.yellow100

@MeasurementListItem = React.createClass

  onTouchTap: (e) ->
    if @props.onTouchTap
      @props.onTouchTap e, @props.measurement

  acceptTechnicalDebt: (m) -> =>
    Meteor.call 'acceptTechnicalDebt', m

  clearTechnicalDebt: (m) -> =>
    Meteor.call 'clearTechnicalDebt', m

  renderIconMenu: (m)->
    metric = @props.metric
    style = display: 'none'
    if m?.status?.value is 'nok' or metric.acceptedTechnicalDebt
      style.display = 'inline'
    <IconMenu
      style=style
      iconButtonElement={<IconButton><NavigationMoreVert /></IconButton>}
      anchorOrigin={horizontal: 'right', vertical: 'bottom'}
      targetOrigin={horizontal: 'right', vertical: 'top'}
    >
    {if m?.status?.value is 'nok'
      <MenuItem primaryText="Accept as technical debt" onTouchTap={@acceptTechnicalDebt m} />
    }
    {if metric?.acceptedTechnicalDebt
      <MenuItem primaryText="Clear accepted technical debt" onTouchTap={@clearTechnicalDebt m} />
    }
    </IconMenu>

  render: ->
    secondaryText = (m) ->
      if m and Utils.isEmpty(m) then i18n('measurement.failing')
      else if not m then i18n('measurement.noMeasurements')

    m = @props.measurement
    avatar = <MeasurementAvatar measurement={m} />
    <ListItem
      primaryText={@props.title}
      secondaryText={secondaryText m}
      leftAvatar={avatar}
      disabled={not m?}
      onTouchTap={@onTouchTap}
      rightIconButton={@renderIconMenu m}
      style={unless @props.metric.acceptedTechnicalDebt is undefined then styles.atd}
    />
