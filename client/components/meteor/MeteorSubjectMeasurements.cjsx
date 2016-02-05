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

@MeteorSubjectMeasurements = React.createClass
  render: ->
    <Paper style={styles.paper}>
      <h3 style={styles.h3}>{@props.subject.name}</h3>
      {if @props.subject.metrics?.length
        console.log '@props.subject.metrics?', @props.subject.metrics
        <List style={styles.list}>
          {for metric in @props.subject.metrics
            <MeteorSubjectMeasurement subject={@props.subject} metric={metric} />}
        </List>
      else
        <span>No metrics configured</span>}
    </Paper>

MeteorSubjectMeasurement = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    measurement: Measurements.findOne({forSubject: @props.subject.name, ofMetric: @props.metric.name}, {sort: lastMeasured: -1})

  render: ->
    console.log 'render MeteorSubjectMeasurement'
    <SubjectMeasurement title={@props.metric.name} measurement={@data.measurement} />
