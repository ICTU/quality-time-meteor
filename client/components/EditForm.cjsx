{ Paper, ClearFix, TextField, RaisedButton } = mui

formStyle =
  padding: 15

btnStyle =
  marginTop: 15

capitalize = (text) ->
  [first, rest...] = text
  "#{first.toUpperCase()}#{rest.join('')}"

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getInitialState: ->
    @props.data

  save: -> @props.onSave @state

  render: ->
    <span>
      <Paper style={formStyle}>
        {for field in @props.fields
          <ClearFix key={field}>
            <TextField ref={field}
              hintText={capitalize(field)}
              valueLink={@linkState "#{field}"}/>
          </ClearFix>}
      </Paper>
      <RaisedButton label="Save" style={btnStyle} onTouchTap={@save}/>
    </span>
