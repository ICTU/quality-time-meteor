{ Paper, ClearFix, TextField, RaisedButton } = mui

styles =
  form:
    padding: 15
  button:
    marginTop: 15

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getInitialState: ->
    @props.doc

  save: -> @props.onSave @state

  delete: -> @props.onDelete @state

  render: ->
    <span>
      <Paper style={styles.form}>
        {for field in @props.fields
          <EditField key={field} field={field} valueLink={@linkState "#{field}"}/>}
      </Paper>
      <RaisedButton label="Save" onTouchTap={@save} style={styles.button}/>
      <RaisedButton label="Delete" onTouchTap={@delete}
        primary={true}
        style={_.extend {marginLeft: 20}, styles.button}/>
    </span>
