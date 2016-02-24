@SubjectPage = React.createClass
  displayName: 'SubjectPage'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subject = Subjects.findOne @props.id
    subject: subject


  render: ->
    <Page style={padding:10}>
      <h2 style={color:'#483D8B'}>{@data.subject.name}</h2>
    </Page>
