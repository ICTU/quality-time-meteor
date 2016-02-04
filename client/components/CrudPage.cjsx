{ Dialog, FlatButton, ClearFix } = mui

@CrudPage = React.createClass
  displayName: 'CrudPage'

  mixins: [_i18n.refreshOnChangeLocaleMixin]

  propTypes:
    listFields: React.PropTypes.array.isRequired
    editFields: React.PropTypes.array.isRequired
    documents: React.PropTypes.array.isRequired
    onSave: React.PropTypes.func.isRequired

  getInitialState: ->
    selectedDoc: null
    leftNavOpen: false

  onDocumentSelected: (doc) ->
    FlowRouter.go "/sources/edit/#{doc._id}"
    #@setState selectedDoc: doc

  dialogCancelled: ->
    @setState selectedDoc: null

  dialogSaved: ->
    @refs.editForm.save()
    @setState selectedDoc: null

  handleCreateTouchTap: ->
    @setState selectedDoc: {}

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

    # <ClearFix><FlatButton primary={true} style={float:'right'} onTouchTap={@handleCreateTouchTap}><T>button.create</T></FlatButton></ClearFix>
    <span>
      <CollectionList documents={@props.documents} fields={@props.listFields} onDocumentSelected={@onDocumentSelected} />
      <LeftNav
          docked={false}
          width={1600}
          openRight={true}
          open={@state.selectedDoc isnt null}
          style={marginTop:60, padding:10}
          overlayClassName='overlay'
          onRequestChange={(open) => @setState selectedDoc: null}
        >
        {if @state.selectedDoc isnt null
            <EditForm
              ref='editForm'
              onSave={@props.onSave}
              showActionButtons={false}
              fields={@props.editFields}
              doc={@state.selectedDoc}
              customRenderer={@props.customRenderer}/>
        }
        <div style={textAlign: 'right', paddingTop: 20}>
          <FlatButton
            label="Cancel"
            secondary={true}
            onTouchTap={@dialogCancelled} />
          <FlatButton
            label="Save"
            primary={true}
            keyboardFocused={true}
            onTouchTap={@dialogSaved} />
        </div>
      </LeftNav>
    </span>
    # <Dialog
    #     title='Edit'
    #     modal={true}
    #     open={@state.selectedDoc isnt null}
    #     actions={actions}
    #     onRequestClose={@handleClose}>
    #     { if @state.selectedDoc isnt null
    #         <EditForm
    #           ref='editForm'
    #           onSave={@props.onSave}
    #           showActionButtons={false}
    #           fields={@props.editFields}
    #           doc={@state.selectedDoc}
    #           customRenderer={@props.customRenderer}/>
    #     }
    # </Dialog>
