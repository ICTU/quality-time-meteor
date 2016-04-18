@Comments = new Mongo.Collection 'comments'

Schema.Comments =
  userId: type: String
  measurementId: type: String
  summary: type: String
  text:
    type: String
    autoform:
      rows: 5
