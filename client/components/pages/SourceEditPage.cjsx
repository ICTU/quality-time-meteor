{ Dialog , FlatButton } = mui

@SourceEditPage = React.createClass
  displayName: 'SourceEditPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    if @props.id
      source: Sources.findOne _id: @props.id
      type: SourceTypes.findOne name: 'Jira'
    else {}

  onCancelTapped: ->
    FlowRouter.go '/sources'

  onSaveTapped: ->
    @refs.editForm.save()
    FlowRouter.go '/sources'

  onSave: (doc) ->
    Meteor.call 'Sources.upsert', doc
    @setState snackbarOpen: true

  render: ->
    console.log '!!', Schema[@data.type.name]
    console.log _.extend Schema.Sources, Schema[@data.type.name]
    console.log '@data', @data
    title = if @props.id then <T name={@data.source.name}>source.edit</T> else <T>source.add</T>

    <span>
      <Page title={title} style={padding:10}>

        <EditForm
          ref='editForm'
          onSave={@onSave}
          showActionButtons={false}
          schema={_.extend Schema.Sources, Schema[@data.type.name]}
          doc={@data.source}
          customRenderer={@customRenderer}/>

      </Page>

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
    </span>
