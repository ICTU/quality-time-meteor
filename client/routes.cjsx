FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Welcome'
      currentRoute: '/'
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourcesPage />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>subjects</T>
      currentRoute: '/subjects'
      content: -> <SubjectsPage />

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>dashboard</T>
      currentRoute: '/dashboard'
      content: -> <DashboardPage />
