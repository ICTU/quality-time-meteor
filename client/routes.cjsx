FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Welcome'
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Sources'
      content: -> <SourcesPage />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Subjects'
      content: -> <SubjectsPage />

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Dashboard'
      content: -> <MeteorComponentMeasurements />
