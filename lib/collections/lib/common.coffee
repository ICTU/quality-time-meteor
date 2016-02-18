Mongo.Collection::register = (doc, cb) ->
  @upsert {name: doc.name}, doc
  cb? doc
