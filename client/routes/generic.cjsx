
@loggedInGroup = FlowRouter.group
 triggersEnter: [ ->
   unless Meteor.loggingIn() or Meteor.userId()
     route = FlowRouter.current()
     #unless route.route.name is 'login'
       #Session.set 'redirectAfterLogin', route.path
     FlowRouter.go 'login'
 ]

FlowRouter.route '/',
  action: ->
    FlowRouter.go '/dashboard'

FlowRouter.route '/login',
  name: 'login'
  action: ->
    ReactLayout.render MainLayout,
      title: 'Quality Time'
      currentRoute: '/login'
      content: ->
        <Page title='Login'
          style={paddingTop:100,paddingBottom:100}>
          <Accounts.ui.LoginFormSet />
        </Page>

loggedInGroup.route '/account',
  name: 'account'
  action: ->
    ReactLayout.render MainLayout,
      title: 'Account'
      currentRoute: '/account'
      content: ->
        <Page title='Change Password'
          style={paddingTop:100,paddingBottom:100}>
          <Accounts.ui.LoginFormSet />
        </Page>

loggedInGroup.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>dashboard</T>
      currentRoute: '/dashboard'
      content: -> <TreemapDashboardPage />
