@MeteorSubjectMeasurements = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subjects: Subjects.find({}, sort: name: 1).fetch()

  render: ->
    <span>
      {for subject in @data.subjects
        <MeteorSubjectMeasurement key={subject._id} subject={subject} />
      }
    </span>


@MeteorSubjectMeasurement = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    measurements = for metric in @props.subject.metrics
      Measurements.findOne({forSubject: @props.subject.name, ofMetric: metric.name}, {sort: lastMeasured: -1})
    measurements: _.filter measurements, (m) -> m?

  render: ->
    <SubjectMeasurements title={@props.subject.name} measurements={@data.measurements} />
