measurementStub =
  ofMetric: 'myMetric'

describe 'MeasurementListItem', ->

  renderComponent = (measurement = {})->
    stub = _.extend measurementStub, measurement
    component = render <MeasurementListItem measurement={stub} />

  it 'displays the metric name', ->
    expect(renderComponent().props.primaryText).toBe 'myMetric'
