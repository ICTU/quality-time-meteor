{ Paper, Divider, Toolbar, ToolbarGroup, ToolbarTitle, FlatButton } = mui

@Page = React.createClass

  render: ->
    <Paper>
      <Toolbar style={paddingRight:0}>
        <ToolbarGroup firstChild={true} float='left'>
          <ToolbarTitle style={paddingLeft:15} text={@props.title} />
        </ToolbarGroup>
        {if @props.actionButtons
          <ToolbarGroup firstChild={true} float='right'>
            {@props.actionButtons}
          </ToolbarGroup>
        }
      </Toolbar>
      <Divider />
      <div style={padding:15, backgroundColor:'white'}>
        {@props.children}
      </div>
    </Paper>
