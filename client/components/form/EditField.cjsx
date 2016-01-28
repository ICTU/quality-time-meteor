{ ClearFix, TextField } = mui

@EditField = React.createClass
  displayName: 'EditField'

  render: ->
    capitalizedField = Utils.capitalize(@props.field)
    <ClearFix>
      <TextField ref={@props.field}
        style={width:'100%'}
        floatingLabelText={capitalizedField}
        {... @props} />
    </ClearFix>
