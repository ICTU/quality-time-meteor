{ Dialog , FlatButton } = mui

@SourceEditPage = React.createClass
  displayName: 'SourceEditPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    source = Sources.findOne _id: @props.id
    type: SourceTypes.findOne name: (@props.sourceTypeName or source.type)
    source: source

  onCancelTapped: ->
    FlowRouter.go '/sources'

  onSaveTapped: ->
    @refs.editForm.save()
    FlowRouter.go '/sources'

  onSave: (doc) ->
    doc.type = @data.type.name
    doc.icon = @data.type.icon
    Meteor.call 'Sources.upsert', doc
    @setState snackbarOpen: true

  render: ->
    title = if @props.id then <T name={@data.source.name}>source.edit</T> else <T type={@data.type.name}>source.add</T>
    schema = if typeSchema = Schema[@data.type.name]
      _.extend {}, Schema.Sources, typeSchema
    else Schema.Sources

    <Page title={title} style={padding:10}>
      <Card>
        <EditForm
          ref='editForm'
          onSave={@onSave}
          showActionButtons={false}
          schema=schema
          doc={@data.source}
          customRenderer={@customRenderer}/>
      </Card>
      <div style={textAlign: 'right', paddingTop: 20}>
        <FlatButton
          label={<T>button.cancel</T>}
          secondary={true}
          onTouchTap={@onCancelTapped} />
        <FlatButton
          label={<T>button.save</T>}
          primary={true}
          keyboardFocused={true}
          onTouchTap={@onSaveTapped} />
      </div>
    </Page>
