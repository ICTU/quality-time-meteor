@Card = React.createClass
  render: ->
    style = _.extend
      padding: 10
      marginBottom: 10
    , @props.style

    <Paper className='card' {...@props} style={style}>
      {@props.children}
    </Paper>
