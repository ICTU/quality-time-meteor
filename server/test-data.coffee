testSources = [
    name: 'RApp Jenkins'
    description: "Referendum Applicatie Jenkins CI"
    url: 'http://www.jenkins.kiesraad.ictu/'
    icon : '/images/sources/jenkins_icon.png'
    type: 'Jenkins'
  ,
    name: 'Inspectieviews Jenkins'
    description: "Inspectieviews Jenkins CI"
    url: 'http://www.jenkins.inspectieviews.ictu/'
    icon : '/images/sources/jenkins_icon.png'
    type: 'Jenkins'
  ,
    name: 'Metrics Kwaliteit Jenkins'
    description: "Metrics Kwaliteit Jenkins CI"
    url: 'http://jenkins.isf.org:8080/'
    icon : '/images/sources/jenkins_icon.png'
    type: 'Jenkins'
  ,
    name: 'LRK Sonar'
    description: "The Sonar of LRK"
    url: 'http://www.sonar.lrk.ictu:9000/'
    icon : '/images/sources/sonar_icon.png'
    type: 'Sonar'
  ,
    name: 'Inspectieviews Sonar'
    description: "The Sonar of Inspectieviews"
    url: 'http://www.sonar.inspectieviews.ictu:9000/'
    icon : '/images/sources/sonar_icon.png'
    type: 'Sonar'
]

addTestData = (collection, data) ->
  if collection.find().count() is 0
    collection.register item for item in data

Meteor.startup ->
  addTestData Sources, testSources
