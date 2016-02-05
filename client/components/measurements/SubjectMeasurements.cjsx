@SubjectMeasurement = React.createClass

  openDialog: (e, metric)->
    @refs['DslHtmlView'].open()

  render: ->
    m = @props.measurement
    <span>
      <MeasurementListItem
        title={@props.title}
        measurement={m}
        onTouchTap={@openDialog} />
        <DslHtmlView ref='DslHtmlView' key={m._id} ast={JSON.parse m.calculation}
            statusAst={JSON.parse m.status.calculation}/>
    </span>
