@SubjectsPage = React.createClass
  displayName: 'SubjectsPage'

  render: ->
    fields = ['name']
    editFields = ['name', {'jenkins': ['jobName']}]

    <Page title='All subjects'>
      <MeteorCrudPage
        collection={Subjects}
        listFields={fields}
        editFields={editFields}
        itemName='Subject'
        />
    </Page>
