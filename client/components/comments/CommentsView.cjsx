@CommentsView = React.createClass
  displayName: 'CommentsView'

  render: ->
    <List {...@style}>
      {if @props.comments?.length
        for comment in @props.comments
          <Comment key={comment._id} comment=comment />
      else
        <strong>There are no comments yet.</strong>
      }
    </List>
