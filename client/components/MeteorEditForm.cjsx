@MeteorEditForm = React.createClass
  displayName: 'MeteorEditForm'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    document: @props.collection.findOne _id: @props.docId

  onSave: (doc) -> @props.collection.upsert _id: doc._id, doc

  onDelete: (doc) -> @props.collection.remove _id: doc._id

  render: ->
    <EditForm
      id={@props.docId}
      data={@data.document}
      fields={@props.fields}
      onSave={@onSave}
      onDelete={@onDelete}/>
