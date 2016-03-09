@ExpandableCard = React.createClass
  displayName: 'ExpandableCard'

  getInitialState: ->
    expanded: false

  handleTouchTap: ->
    @setState expanded: not @state.expanded

  render: ->

    contentStyle =
      height: 0
      transition: 'height .2s linear'
      overflow: 'hidden'
    cardStyle =
      borderRadius: 0
      marginBottom: 0
    if @state.expanded
      contentStyle.height = 100
      cardStyle.marginBottom = 10

    <Card {...@props} style=cardStyle>
      <div onTouchTap={@handleTouchTap} style={cursor:'pointer'}>
        {@props.headerElement}
      </div>
      <div style=contentStyle>
        {@props.children}
      </div>
    </Card>
