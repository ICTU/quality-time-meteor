FlowRouter.route '/',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Welcome</h1>

FlowRouter.route '/sources',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <SourcesPage />

FlowRouter.route '/source-types',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <MeteorSourceTypesList />

FlowRouter.route '/subjects',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <MeteorSubjectsList />

FlowRouter.route '/metrics',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <h1>Metrics</h1>

FlowRouter.route '/dashboard',
  action: ->
    ReactLayout.render MainLayout,
      content: -> <MeteorComponentMeasurements />

FlowRouter.route '/source/:docId/edit',
  name: '/source/:docId/edit'
  action: (params)->
    ReactLayout.render MainLayout,
      content: -> <MeteorEditForm
        fields={['name', 'url', 'description', 'image']}
        collection={Sources}
        docId={params.docId} />
