{ Dialog , FlatButton } = mui

@SourcesPage = React.createClass
  displayName: 'SourcesPage'

  render: ->
    fields = ['name', 'description']
    editFields = ['name', 'url', 'description', 'image', 'icon']

    <Page title='All sources'>
      <MeteorCrudPage
        collection={Sources}
        listFields={fields}
        editFields={editFields}
        itemName='Source'
        />
    </Page>
