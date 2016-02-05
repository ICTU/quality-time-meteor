sources = FlowRouter.group
  prefix: '/sources'
  name: 'sources'

sources.route '/',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourcesPage />

sources.route '/edit/:_id',
  action: (params) ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourceEditPage id={params._id}/>

sources.route '/new',
  action: ->
    ReactLayout.render MainLayout,
      title: <T>sources</T>
      currentRoute: '/sources'
      content: -> <SourceEditPage />
