@CommentsView = React.createClass
  displayName: 'CommentsView'

  render: ->
    <span>
      <NewComment {...@props}/>
      <List subheader="Comments" {...@style}>
        {if @props.comments?.length
          for comment in @props.comments
            <Comment key={comment._id} comment=comment />
        else
          <strong>There are no comments yet.</strong>
        }
      </List>
    </span>

@Comment = React.createClass
  displayName: 'Comment'

  render: ->
    <ListItem
      primaryText={@props.comment.summary}
      secondaryText={@props.comment.text}
      leftAvatar={<Avatar src={@props.comment.avatar} />}
    />

@NewComment = React.createClass
  displayName: 'NewComment'

  mixins: [LinkedStateMixin]

  getInitialState: ->
    summary: ''
    text: ''

  dialogCancelled: -> @setState @getInitialState()

  dialogSaved: ->
    @props.onAddComment @state
    @setState @getInitialState()

  render: ->
    title = 'test'
    text = 'test'
    <span>
      <ClearFix {... @props}>
        <TextField
          {...@props}
          valueLink={@linkState 'summary'}
          hintText="Comment summary"
          floatingLabelText="Summary"
        />
      </ClearFix>
      <ClearFix {... @props}>
        <TextField
          {...@props}
          valueLink={@linkState 'text'}
          hintText="Comment text"
          floatingLabelText="Text"
          multiLine={true}
          rows={2}
        />
      </ClearFix>
      <div>
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
    </span>
