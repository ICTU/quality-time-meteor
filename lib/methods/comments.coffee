Meteor.methods
  'comments/add': (doc) ->
    if Meteor.userId()
      Comments.insert _.extend {userId: Meteor.userId(), created: new Date()}, doc
    else
      console.error "Can't add a comment when no user is logged in!"
