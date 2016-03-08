@Page = React.createClass

  render: ->
    <div className='page'>
      {if @props.title then <h3>{@props.title}</h3>}
      <Paper style={@props.style}>
        <div style={backgroundColor:'white'}>
          {@props.children}
        </div>
      </Paper>
    </div>
