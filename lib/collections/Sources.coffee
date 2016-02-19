@Sources = new Mongo.Collection 'sources'

SimpleSchema.extendOptions
  autoform: Match.Optional(Object)

Sources.attachSchema new SimpleSchema
  name: type: String
  url:
    type: String
    optional: true
  description:
    type: String
    optional: true
  image:
    type: String
    optional: true
  icon:
    type: String
    optional: true
  type:
    type: String
    autoform:
      options: -> SourceTypes.find().map (st) ->
        value: st._id
        label: st.name
