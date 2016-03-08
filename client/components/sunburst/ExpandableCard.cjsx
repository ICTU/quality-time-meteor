@ExpandableCard = React.createClass
  displayName: 'ExpandableCard'

  getInitialState: ->
    expanded: false

  handleTouchTap: ->
    @setState expanded: not @state.expanded

  render: ->

    divStyle =
      maxHeight: 0
      transition: 'max-height .2s linear'
      overflow: 'hidden'
    if @state.expanded
      divStyle.maxHeight = 100

    <Card {...@props}>
      <div onTouchTap={@handleTouchTap}>
        {@props.headerElement}
      </div>
      <div style=divStyle>
        {@props.children}
      </div>
    </Card>
