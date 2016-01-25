{ Paper, ClearFix, TextField, RaisedButton } = mui

styles =
  form:
    padding: 15
  button:
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

  delete: -> @props.onDelete @state

  render: ->
    <span>
      <Paper style={styles.form}>
        {for field in @props.fields
          <ClearFix key={field}>
            <TextField ref={field}
              hintText={capitalize(field)}
              valueLink={@linkState "#{field}"}/>
          </ClearFix>}
      </Paper>
      <RaisedButton label="Save" onTouchTap={@save} style={styles.button}/>
      <RaisedButton label="Delete" onTouchTap={@delete}
        primary={true}
        style={_.extend {"margin-left": 20}, styles.button}/>
    </span>
