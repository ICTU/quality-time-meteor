@MeteorCrudPage= React.createClass
  displayName: 'MeteorCrudPage'

  mixins: [ReactMeteorData]

  propTypes:
    collection: React.PropTypes.object.isRequired
    listFields: React.PropTypes.array.isRequired
    editFields: React.PropTypes.array.isRequired

  getMeteorData: ->
    documents: @props.collection.find().fetch()

  onSave: (doc) -> @props.collection.upsert _id: doc._id, doc

  render: ->
    <CrudPage
      onSave={@onSave}
      documents={@data.documents}
      listFields={@props.listFields}
      editFields={@props.editFields} />
