Meteor.startup ->
  SourceTypes.remove {}

  SourceTypes.register = (impl) ->
    # register the source type with the system
    SourceTypes.upsert {name: impl.name}, impl

    console.log "SourceType registered: #{impl.name}"
