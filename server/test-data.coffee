testSources = [
    name: 'RApp Jenkins'
    description: "Referendum Applicatie Jenkins CI"
    url: 'http://www.jenkins.kiesraad.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    class: 'Jenkins'
  ,
    name: 'Inspectieviews Jenkins'
    description: "Inspectieviews Jenkins CI"
    url: 'http://www.jenkins.inspectieviews.ictu/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    class: 'Jenkins'
  ,
    name: 'Metrics Kwaliteit Jenkins'
    description: "Metrics Kwaliteit Jenkins CI"
    url: 'http://jenkins.isf.org:8080/'
    image: "https://blog.rosehosting.com/blog/wp-content/uploads/2014/11/jenkins.png"
    icon: "/images/jenkins/icon.png"
    class: 'Jenkins'
]

testSubjects = [
    name: 'Referendum Applicatie'
    jenkins:
      jobName: 'RApp'
  ,
    name: 'Inspectieviews ISZW'
    jenkins:
      jobName: 'av-ingestion-iszw'
  ,
    name: 'Inspectieviews Bedrijven WSDL'
    jenkins:
      jobName: 'iv-bedrijven-wsdl'
  ,
    name: 'Metrics Kwaliteit'
    jenkins:
      jobName: 'metrics-kwaliteit'

]

addTestData = (collection, data) ->
  if collection.find().count() is 0
    collection.register item for item in data

Meteor.startup ->
  addTestData Sources, testSources
  addTestData Subjects, testSubjects
