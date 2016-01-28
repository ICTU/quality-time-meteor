{ Dialog, FlatButton } = mui

@CrudPage = React.createClass
  displayName: 'CrudPage'

  propTypes:
    listFields: React.PropTypes.array.isRequired
    editFields: React.PropTypes.array.isRequired
    documents: React.PropTypes.array.isRequired
    onSave: React.PropTypes.func.isRequired

  getInitialState: ->
    selectedDoc: null

  onDocumentSelected: (doc) ->
    @setState selectedDoc: doc

  dialogCancelled: ->
    @setState selectedDoc: null

  dialogSaved: ->
    @refs.editForm.save()
    @setState selectedDoc: null

  render: ->

    actions = [
      <FlatButton
        label="Cancel"
        secondary={true}
        onTouchTap={@dialogCancelled} />
      <FlatButton
        label="Save"
        primary={true}
        keyboardFocused={true}
        onTouchTap={@dialogSaved} />
    ]

    <span>
      <CollectionList documents={@props.documents} fields={@props.listFields} onDocumentSelected={@onDocumentSelected} />
      <Dialog
          title='Edit'
          modal={true}
          open={@state.selectedDoc isnt null}
          actions={actions}
          onRequestClose={@handleClose}>
          { if @state.selectedDoc isnt null
              <EditForm
                ref='editForm'
                onSave={@props.onSave}
                showActionButtons={false}
                fields={@props.editFields}
                doc={@state.selectedDoc} />
          }
      </Dialog>
    </span>
