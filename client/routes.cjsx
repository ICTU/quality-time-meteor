FlowRouter.route '/',
  action: ->
    ReactLayout.render App,
      content: <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render App,
      content: <h1>Sources</h1>

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render App,
      content: <h1>Subjects</h1>

FlowRouter.route '/metrics',
  action: ->
    ReactLayout.render App,
      content: <h1>Metrics</h1>
