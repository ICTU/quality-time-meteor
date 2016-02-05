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
    measurements: Measurements.find({forSubject: @props.subject.name}, {sort: lastMeasured: -1}).fetch()

  render: ->
    <SubjectMeasurements title={@props.subject.name} measurements={@data.measurements} />
