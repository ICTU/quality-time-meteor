@DashboardPage = React.createClass
  displayName: 'DashboardPage'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subjects = Subjects.find({}, sort: name: 1).fetch()

    subjectMeasurements = {}
    subjectMeasurements[subject._id] = getsubjectMetricMeasurements subject for subject in subjects

    subjects: subjects
    subjectMeasurements: subjectMeasurements

  render: ->
    <span>
      <Card>
        <h2 style={color:'#483D8B'}><T>titles.general_quality</T></h2>
        <SubjectsMetricMeasurementSunburst subjects={@data.subjects} subjectMeasurements={@data.subjectMeasurements} />
      </Card>
      <Card>
        <h2 style={color:'#483D8B'}><T>titles.subjects</T></h2>
        <table>
          <thead>
            <tr>
              <td>Status</td>
              <td>Subject</td>
              <td>Description</td>
            </tr>
          </thead>
          <tbody>
            {for subject in @data.subjects
              <tr>
                <td><FontIcon className="material-icons" style={fontSize:40} color='#66BB6A'>sentiment_satisfied</FontIcon></td>
                <td>{subject.name}</td>
                <td></td>
              </tr>
            }
          </tbody>
        </table>
      </Card>
    </span>

# {for subject in @data.subjects
#   <MeteorSubjectMeasurements key={subject._id} subject={subject} />
# }
