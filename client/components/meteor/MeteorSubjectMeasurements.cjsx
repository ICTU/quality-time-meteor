@MeteorSubjectMeasurements = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subjects: Subjects.find({}, sort: name: 1).fetch()

  render: ->
    <span>
      {for subject in @data.subjects
        <SubjectMeasurements key={subject._id} title={subject.name} measurements={[]} />
      }
    </span>
