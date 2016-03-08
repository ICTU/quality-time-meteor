@PageElement = React.createClass

  render: ->
    <div className='pageElement'>
      <Toolbar className='toolbar'>
        <ToolbarGroup firstChild={true} float="left">
          {if @props.title then <ToolbarTitle className='toolbarTitle' text={@props.title} />}
        </ToolbarGroup>
        <ToolbarGroup float="right">
          {if @props.rightElement then @props.rightElement}
        </ToolbarGroup>
      </Toolbar>
      {@props.children}
    </div>
