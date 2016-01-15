Meteor.startup ->
  SourceTypes.remove {}

  SourceTypes.register = (name, impl) ->
      SourceTypes.upsert {name: name},
        $set:
          _.extend {name: name}, impl
      console.log "Source implementation registered: #{name}"
