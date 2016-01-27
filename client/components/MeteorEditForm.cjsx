@MeteorEditForm = React.createClass
  displayName: 'MeteorEditForm'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    document: @props.collection.findOne _id: @props.docId

  onSave: (doc) -> @props.collection.upsert _id: doc._id, doc

  onDelete: (doc) -> @props.collection.remove _id: doc._id

  save: -> @refs.editForm.save()
  delete: -> @refs.editForm.delete()

  render: ->
    <EditForm
      id={@props.docId}
      ref='editForm'
      doc={@data.document}
      showActionButtons={@props.showActionButtons}
      fields={@props.fields}
      onSave={@onSave}
      onDelete={@onDelete}/>
