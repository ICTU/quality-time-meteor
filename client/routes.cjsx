FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Welcome'
      currentRoute: '/'
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Sources'
      currentRoute: '/sources'
      content: -> <SourcesPage />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Subjects'
      currentRoute: '/subjects'
      content: -> <SubjectsPage />

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Dashboard'
      currentRoute: '/dashboard'
      content: -> <MeteorComponentMeasurements />
