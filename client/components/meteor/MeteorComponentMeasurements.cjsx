@MeteorComponentMeasurements = React.createClass

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

    q1 = forSubject: 'Ingestion DCMR', ofMetric: 'TotalUnitTests'
    q2 = forSubject: 'Ingestion DCMR', ofMetric: 'PassedUnitTests'
    i7 = Measurements.findOne(q1, sort: lastMeasured: -1)
    i8 = Measurements.findOne(q2, sort: lastMeasured: -1)

    measurements:
      rapp: [r1, r2]
      inspectieviews: [i1, i2]
      inspectieviews2: [i3, i4]
      x: [i5, i6]
      y: [i7, i8]


  render: ->
    <span>
      <ComponentMeasurements measurements={@data.measurements.rapp} />
      <ComponentMeasurements measurements={@data.measurements.inspectieviews} />
      <ComponentMeasurements measurements={@data.measurements.inspectieviews2} />
      <ComponentMeasurements measurements={@data.measurements.x} />
      <ComponentMeasurements measurements={@data.measurements.y} />
    </span>
