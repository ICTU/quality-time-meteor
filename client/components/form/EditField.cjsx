@EditField = React.createClass
  displayName: 'EditField'

  render: ->
    capitalizedField = Utils.capitalize(@props.field)
    <ClearFix {... @props}>
      <TextField ref={@props.field}
        style={width:'100%'}
        floatingLabelText={capitalizedField}
        {... @props} />
    </ClearFix>
