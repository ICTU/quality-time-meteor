@Sources = new Mongo.Collection 'sources'

Schema.Sources =
  name: type: String
  url:
    type: String
    optional: true
  description:
    type: String
    optional: true
  # icon:
  #   type: String
  #   autoform:
  #     options: -> SourceTypes.find().map (st) ->
  #       value: st.icon
  #       label: st.icon
  # type:
  #   type: String
  #   autoform:
  #     options: -> SourceTypes.find().map (st) ->
  #       value: st._id
  #       label: st.name

#Sources.attachSchema new SimpleSchema Schema.Sources
