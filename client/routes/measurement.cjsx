metrics = loggedInGroup.group
  prefix: '/metrics'
  name: 'metrics'

metrics.route '/:metricId/measurement/:measurementId',
  action: (params) ->
    ReactLayout.render MainLayout,
      title: <T>measurement</T>
      currentRoute: '/metrics'
      content: -> <SubjectMetricDetailPage
        metricId={params.metricId}
        measurementId={params.measurementId} />
