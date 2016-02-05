FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Welcome'
      currentRoute: '/'
      content: -> <h1>Welcome</h1>

FlowRouter.route '/login',
  action: ->
    ReactLayout.render MainLayout,
      title: 'Login'
      currentRoute: '/login'
      content: -> <Accounts.ui.LoginFormSet />

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>dashboard</T>
      currentRoute: '/dashboard'
      content: -> <DashboardPage />
