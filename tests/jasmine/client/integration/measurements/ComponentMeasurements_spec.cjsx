{ List, ListItem, Avatar, Styles } = mui
{ Colors } = Styles

measurements = [
  _id: 'id1'
  firstMeasured: new Date()
  lastMeasured: new Date()
  forSubject: 'subject1'
  ofMetric: 'TotalUnitTests'
  value: 10
  calculation: Q.toJSON Q.val 'totalUnitTests', 10
  status:
    value: 'ok'
    calculation: Q.toJSON Q.val 'status', 'ok'
]

describe 'ComponentMeasurements', ->
  it 'displays the component name', ->
    component = render <ComponentMeasurements measurements={measurements} />
    expect(component.props.children[0].props.children).toBe 'subject1'
