@Comment = React.createClass
  displayName: 'Comment'

  render: ->
    <ListItem
      primaryText={@props.comment.text}
      secondaryText={moment(@props.comment.created).fromNow()}
      leftAvatar={<Avatar src={@props.comment.avatar} />}
    />
