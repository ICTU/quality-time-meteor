@Page = React.createClass

  render: ->
    <div className='page'>
      {if @props.title then <h3>{@props.title}</h3>}
      {@props.children}
    </div>
