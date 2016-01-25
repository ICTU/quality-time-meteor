Mongo.Collection::register = (doc) ->
  @upsert {name: doc.name}, doc
  console.log "Source implementation registered: #{doc.name}"
