{ Dialog , FlatButton } = mui

@SourceEditPage = React.createClass
  displayName: 'SourceEditPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    if @props.id
      Sources.findOne _id: @props.id
    else {}

  onCancelTapped: ->
    FlowRouter.go '/sources'

  onSaveTapped: ->
    @refs.editForm.save()
    FlowRouter.go '/sources'
  onSave: (doc) ->
    Sources.upsert _id: doc._id, doc
    @setState snackbarOpen: true

  render: ->
    editFields = ['name', 'url', 'description', 'image', 'icon']
    title = if @props.id then "Edit #{@data.name}" else 'Add source'

    <span>
      <Page title={title} style={padding:10}>

        <EditForm
          ref='editForm'
          onSave={@onSave}
          showActionButtons={false}
          fields={editFields}
          doc={@data}
          customRenderer={@customRenderer}/>

      </Page>

      <div style={textAlign: 'right', paddingTop: 20}>
        <FlatButton
          label="Cancel"
          secondary={true}
          onTouchTap={@onCancelTapped} />
        <FlatButton
          label="Save"
          primary={true}
          keyboardFocused={true}
          onTouchTap={@onSaveTapped} />
      </div>
    </span>
