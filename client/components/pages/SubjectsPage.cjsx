@SubjectsPage = React.createClass
  displayName: 'SubjectsPage'

  render: ->
    fields = ['name']
    editFields = ['name', {'jenkins': ['jobName']}]

    <MeteorCrudPage collection={Subjects} listFields={fields} editFields={editFields} />
