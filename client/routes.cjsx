FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <SourcesPage />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <SubjectsPage />

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <MeteorComponentMeasurements />
