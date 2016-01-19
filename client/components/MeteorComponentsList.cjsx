@MeteorComponentsList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    q1 = forSubject: 'Referendum Applicatie', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Referendum Applicatie', ofMetric: 'PassedUnitTests'

    r1 = Measurements.findOne(q1, sort: lastMeasured: -1)
    r2 = Measurements.findOne(q2, sort: lastMeasured: -1)
    measurements: [r1, r2]


  render: ->
    <ComponentsList measurements={@data.measurements} />
