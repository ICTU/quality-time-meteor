sources = []

Meteor.startup ->
  SupportedSources.remove {}

@Sources =

  register: (name, impl) ->
    sources[name] = impl
    SupportedSources.upsert {name: name},
      $set:
        _.extend {name: name}, impl
    console.log "Source implementation registered: #{name}"

  get: (name) ->
    sources[name]

  getAll: ->
    Object.keys sources
