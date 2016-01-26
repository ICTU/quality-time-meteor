@MeteorSubjectsList = React.createClass
  displayName: 'MeteorSubjectsList'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    subjects: Subjects.find().fetch()

  render: ->
    <SourcesList sources={@data.subjects} />
