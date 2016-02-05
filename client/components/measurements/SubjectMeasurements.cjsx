@SubjectMeasurement = React.createClass

  openDialog: (e, metric)->
    @refs[metric._id].open()

  renderDetailDialogs: ->
    @props.measurements.map (measurement) ->
      <DslHtmlView ref={measurement._id} key={measurement._id} ast={JSON.parse measurement.calculation}
      statusAst={JSON.parse measurement.status.calculation}/>

  render: ->
    <MeasurementListItem
      title={@props.title}
      measurement={@props.measurement}
      onTouchTap={@openDialog} />
