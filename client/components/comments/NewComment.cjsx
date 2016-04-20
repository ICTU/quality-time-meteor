@NewComment = React.createClass
  displayName: 'NewComment'

  mixins: [LinkedStateMixin]

  getInitialState: ->
    text: ''

  dialogCancelled: ->
    @props.onCancel()
    @setState @getInitialState()

  dialogSaved: ->
    @props.onAddComment @state
    @setState @getInitialState()

  render: ->
    <div>
      <ClearFix {... @props}>
        <TextField
          {...@props}
          style={width:'100%'}
          valueLink={@linkState 'text'}
          hintText="Comment text"
          floatingLabelText="Comment"
          multiLine={true}
          rows={1}
        />
      </ClearFix>
      <div style={textAlign:'right'}>
        <FlatButton
          label="Cancel"
          secondary={true}
          onTouchTap={@dialogCancelled} />
        <FlatButton
          label="Save"
          primary={true}
          keyboardFocused={true}
          onTouchTap={@dialogSaved} />
      </div>
    </div>
