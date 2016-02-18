testSources = [
    name: 'RApp Jenkins'
    description: "Referendum Applicatie Jenkins CI"
    url: 'http://www.jenkins.kiesraad.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    type: 'Jenkins'
  ,
    name: 'Inspectieviews Jenkins'
    description: "Inspectieviews Jenkins CI"
    url: 'http://www.jenkins.inspectieviews.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    type: 'Jenkins'
  ,
    name: 'Metrics Kwaliteit Jenkins'
    description: "Metrics Kwaliteit Jenkins CI"
    url: 'http://jenkins.isf.org:8080/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    type: 'Jenkins'
  ,
    name: 'LRK Sonar'
    description: "The Sonar of LRK"
    url: 'http://www.sonar.lrk.ictu:9000/'
    image: "http://docs.sonarqube.org/download/attachments/6951171/SONAR?version=1&modificationDate=1452514709000&api=v2"
    icon: "http://docs.sonarqube.org/download/attachments/6951171/SONAR?version=1&modificationDate=1452514709000&api=v2"
    type: 'Sonar'
  ,
    name: 'Inspectieviews Sonar'
    description: "The Sonar of Inspectieviews"
    url: 'http://www.sonar.inspectieviews.ictu:9000/'
    image: "http://docs.sonarqube.org/download/attachments/6951171/SONAR?version=1&modificationDate=1452514709000&api=v2"
    icon: "http://docs.sonarqube.org/download/attachments/6951171/SONAR?version=1&modificationDate=1452514709000&api=v2"
    type: 'Sonar'
]

addTestData = (collection, data) ->
  if collection.find().count() is 0
    collection.register item for item in data

Meteor.startup ->
  addTestData Sources, testSources
