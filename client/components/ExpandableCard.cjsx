@ExpandableCard = React.createClass
  displayName: 'ExpandableCard'

  getInitialState: ->
    expanded: @props.expanded or false

  handleTouchTap: ->
    @setState expanded: not @state.expanded

  render: ->

    contentStyle =
      height: 0
      transition: 'margin-bottom 1s linear'
      overflow: 'hidden'
    cardStyle =
      borderRadius: 0
      marginBottom: 0
    if @props.leftAvatar
      contentStyle.marginLeft = 50
    if @state.expanded
      delete contentStyle.height
      cardStyle.marginBottom = 10

    <Card {...@props} style=cardStyle>
      <div onTouchTap={@handleTouchTap} style={cursor:'pointer', display:'flex'}>
        {@props.leftAvatar if @props.leftAvatar}
        {@props.headerElement}
      </div>
      <div style=contentStyle>
        {@props.children}
      </div>
    </Card>
