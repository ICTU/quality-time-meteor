styles =
  paper:
    width:300
    marginBottom: 10
    marginLeft: 5
    float: 'left'
  h3:
    backgroundColor: 'rgba(0, 0, 0, 0.16)'
    padding: 10
    fontWeight: 300
    margin: 0
  list:
    padding: 0
  noMetric:
    textAlign:'center'
    color: 'grey'
    fontWeight:200
    padding:20

@MeteorSubjectMeasurements = React.createClass
  render: ->
    <Paper style={styles.paper}>
      <h3 style={styles.h3}>{@props.subject.name}</h3>
      {if @props.subject.metrics?.length
        <List style={styles.list}>
          {for metric in @props.subject.metrics
            <MeteorSubjectMeasurement key={metric.name} subject={@props.subject} metric={metric} />}
        </List>
      else
        <div style={styles.noMetric}>No metrics configured</div>}
    </Paper>

MeteorSubjectMeasurement = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    measurement = Measurements.findOne({forSubject: @props.subject.name, ofMetric: @props.metric.name}, {sort: lastMeasured: -1})
    comments = Comments.find({metricId: @props.metric.metricId}, {
        transform: (cmt) ->
          userEmail = Meteor.users.findOne(_id: cmt.userId).emails[0].address
          _.extend cmt, avatar: "http://www.gravatar.com/avatar/#{CryptoJS.MD5(userEmail)}"
      }).fetch()
    measurement: measurement
    comments: comments

  render: ->
    <SubjectMeasurement
      title={@props.metric.name}
      subject={@props.subject}
      measurement={@data.measurement}
      metric={@props.metric}
      commentCount={@data.comments.length}
      onAddComment={@addComment}/>
