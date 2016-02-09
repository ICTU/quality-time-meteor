{ Snackbar } = mui

@MeteorCrudPage= React.createClass
  displayName: 'MeteorCrudPage'

  mixins: [ReactMeteorData]

  propTypes:
    collection: React.PropTypes.object.isRequired
    listFields: React.PropTypes.array.isRequired
    editFields: React.PropTypes.array.isRequired
    itemName: React.PropTypes.string.isRequired

  getInitialState: ->
    snackbarOpen: false

  getMeteorData: ->
    documents: @props.collection.find().fetch()

  onSave: (doc) ->
    @props.collection.upsert _id: doc._id, doc
    @setState snackbarOpen: true

  handleSnackbarClose: ->
    @setState snackbarOpen: false

  render: ->
    <span>
      <CrudPage
        onSave={@onSave}
        documents={@data.documents}
        listFields={@props.listFields}
        editFields={@props.editFields}
        customRenderer={@props.customRenderer} />

      <Snackbar
          open={@state.snackbarOpen}
          message={i18n 'item.saved', name: @props.itemName}
          autoHideDuration={0}
          onRequestClose={@handleSnackbarClose}
        />
    </span>
