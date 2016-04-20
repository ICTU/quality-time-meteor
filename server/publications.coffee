Meteor.publish null, ->
  Meteor.users.find {}, fields: emails: 1
