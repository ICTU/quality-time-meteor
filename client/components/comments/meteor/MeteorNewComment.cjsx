@MeteorNewComment = React.createClass
  displayName: 'MeteorNewComment'
  propTypes:
    metricId: React.PropTypes.string.isRequired
    onCommentAdded: React.PropTypes.func
    onCancel: React.PropTypes.func
  onAddComment: (comment) ->
    comment = _.extend {metricId: @props.metricId}, comment
    Meteor.call 'comments/add', comment
    @props.onCommentAdded comment if @props.onCommentAdded
  onCancel: ->
    @props.onCancel() if @props.onCancel
  render: ->
    <NewComment onAddComment={@onAddComment} onCancel={@onCancel}/>
