subjects = loggedInGroup.group
  prefix: '/subjects'
  name: 'subjects'

subjects.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>subjects</T>
      currentRoute: '/subjects'
      content: -> <SubjectsPage />

subjects.route '/new/',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/subjects'
      content: -> <SubjectEditPage />

subjects.route '/:_id/edit',
  action: (params) ->
    ReactLayout.render MainLayout,
      title: <T>subjects</T>
      currentRoute: '/subjects'
      content: -> <SubjectEditPage id={params._id}/>

subjects.route '/:_id/',
  action: (params) ->
    ReactLayout.render MainLayout,
      title: <T>subjects</T>
      currentRoute: '/subjects'
      content: -> <SubjectPage id={params._id}/>
