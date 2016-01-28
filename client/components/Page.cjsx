{ Paper, Divider} = mui

@Page = React.createClass

  render: ->
    <Paper>
      <h2 style={padding:15, backgroundColor:'#f7f7f7'}>{@props.title}</h2>
      <Divider />
      <div style={padding:15, backgroundColor:'white'}>
        {@props.children}
      </div>
    </Paper>
