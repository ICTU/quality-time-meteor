{ Avatar, Styles: { Colors }} = mui

measurementStub =
  value: 10
  status:
    value: 'ok'

describe 'MeasurementAvatar', ->

  renderComponent = (measurement = {})->
    stub = _.extend measurementStub, measurement
    component = render <MeasurementAvatar measurement={stub} />

  it 'displays the measured value', ->
    expect(renderComponent().props.children).toBe 10

  it 'displays a green background when the status is ok', ->
    expect(renderComponent().props.style.backgroundColor)
    .toBe Colors.green400

  it 'displays a red background when the status is not ok', ->
    expect(renderComponent(status: value: 'nok').props.style.backgroundColor)
    .toBe Colors.red500

  it 'displays a blue background when the status is undetermined', ->
    expect(renderComponent(status: value: '?').props.style.backgroundColor)
    .toBe Colors.lightBlue500
