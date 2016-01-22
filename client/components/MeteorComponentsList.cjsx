@MeteorComponentsList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    q1 = forSubject: 'Referendum Applicatie', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Referendum Applicatie', ofMetric: 'PassedUnitTests'
    r1 = Measurements.findOne(q1, sort: lastMeasured: -1)
    r2 = Measurements.findOne(q2, sort: lastMeasured: -1)

    q1 = forSubject: 'Inspectieviews ISZW', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Inspectieviews ISZW', ofMetric: 'PassedUnitTests'
    i1 = Measurements.findOne(q1, sort: lastMeasured: -1)
    i2 = Measurements.findOne(q2, sort: lastMeasured: -1)

    q1 = forSubject: 'Inspectieviews Bedrijven WSDL', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Inspectieviews Bedrijven WSDL', ofMetric: 'PassedUnitTests'
    i3 = Measurements.findOne(q1, sort: lastMeasured: -1)
    i4 = Measurements.findOne(q2, sort: lastMeasured: -1)

    q1 = forSubject: 'Metrics Kwaliteit', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Metrics Kwaliteit', ofMetric: 'PassedUnitTests'
    i5 = Measurements.findOne(q1, sort: lastMeasured: -1)
    i6 = Measurements.findOne(q2, sort: lastMeasured: -1)

    measurements:
      rapp: [r1, r2]
      inspectieviews: [i1, i2]
      inspectieviews2: [i3, i4]
      x: [i5, i6]


  render: ->
    <span>
      <ComponentsList measurements={@data.measurements.rapp} />
      <ComponentsList measurements={@data.measurements.inspectieviews} />
      <ComponentsList measurements={@data.measurements.inspectieviews2} />
      <ComponentsList measurements={@data.measurements.x} />
    </span>
