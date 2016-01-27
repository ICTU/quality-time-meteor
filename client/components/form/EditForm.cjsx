{ Paper, ClearFix, TextField, RaisedButton } = mui

styles =
  form:
    padding: 15
  button:
    marginTop: 15

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getDefaultProps: ->
    showActionButtons: true

  getInitialState: ->
    @props.doc

  save: -> @props.onSave @state

  delete: -> @props.onDelete @state

  render: ->
    <span>
      <div>
        {for field in @props.fields
          <EditField key={field} field={field} valueLink={@linkState "#{field}"}/>}
      </div>
      {if @props.showActionButtons
        <span className='buttons'>
          <RaisedButton label="Save" onTouchTap={@save} style={styles.button}/>
          <RaisedButton label="Delete" onTouchTap={@delete}
            primary={true}
            style={_.extend {marginLeft: 20}, styles.button}/>
        </span>
      }
    </span>
