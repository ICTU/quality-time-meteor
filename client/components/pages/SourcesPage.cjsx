{ Dialog , FlatButton } = mui

@SourcesPage = React.createClass
  displayName: 'SourcesPage'

  getInitialState: ->
    selectedSourceId: -1

  onSourceSelected: (source) ->
    @setState selectedSourceId: source._id

  dialogCancelled: ->
    @setState selectedSourceId: -1

  dialogSaved: ->
    @refs.editForm.save()
    @setState selectedSourceId: -1

  render: ->

    actions = [
      <FlatButton
        label="Cancel"
        secondary={true}
        onTouchTap={@dialogCancelled} />,
      <FlatButton
        label="Save"
        primary={true}
        keyboardFocused={true}
        onTouchTap={@dialogSaved} />
    ]

    <Page title='All sources'>
      <MeteorSourcesList onSourceSelected={@onSourceSelected} />
      <Dialog
          title='Edit source'
          modal={true}
          open={@state.selectedSourceId isnt -1}
          actions={actions}
          onRequestClose={@handleClose}>
          { if @state.selectedSourceId isnt -1
              <MeteorEditForm
                ref='editForm'
                showActionButtons={false}
                fields={['name', 'url', 'description', 'image']}
                collection={Sources}
                docId={@state.selectedSourceId} />
          }
      </Dialog>
    </Page>
