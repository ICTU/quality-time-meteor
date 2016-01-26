{ ClearFix, TextField } = mui

@EditField = React.createClass
  displayName: 'EditField'

  render: ->
    <ClearFix>
      <TextField ref={@props.field}
        hintText={Utils.capitalize(@props.field)}
        valueLink={@props.valueLink}/>
    </ClearFix>
