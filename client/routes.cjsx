FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <MeteorSourceTypesList />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Subjects</h1>

FlowRouter.route '/metrics',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Metrics</h1>
