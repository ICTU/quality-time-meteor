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

  renderIconMenu: (m)->
    if m?.status?.value is 'nok'
      <IconMenu
        iconButtonElement={<IconButton><NavigationMoreVert /></IconButton>}
        anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
        targetOrigin={{horizontal: 'right', vertical: 'top'}}
      >
        <MenuItem primaryText="Accept as technical debt" onTouchTap={@acceptTechnicalDebt m} />
      </IconMenu>
    else <span></span>

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
