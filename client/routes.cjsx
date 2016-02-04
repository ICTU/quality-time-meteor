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

FlowRouter.route '/sources/edit/:_id',
  action: (params) ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourceEditPage id={params._id}/>

FlowRouter.route '/sources/new/',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourceEditPage />

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
