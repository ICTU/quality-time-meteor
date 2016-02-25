@DashboardPage = React.createClass
  displayName: 'DashboardPage'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subjects: Subjects.find({}, sort: name: 1).fetch()

  render: ->
    <span>
      {for subject in @data.subjects
        <MeteorSubjectMeasurements key={subject._id} subject={subject} />
      }
    </span>
