@SubjectMeasurement = React.createClass

  getInitialState: ->
    open: false

  openDialog: (e, metric)->
    @setState open: true

  handleClose: ->
    @setState open: false

  render: ->
    m = @props.measurement
    if m
      parsedCalc = JSON.parse m.calculation
      parsedStatus = JSON.parse m.status.calculation

    <span>
      <MeasurementListItem
        title={@props.title}
        measurement={m}
        onTouchTap={@openDialog} />
        {if m
          <Dialog
            title={@props.title}
            modal={false}
            open={@state.open}
            onRequestClose={@handleClose}>
            <h3>Value</h3>
            <DslHtmlView ast={parsedCalc}/>
            <h3>Status</h3>
            <DslHtmlView ast={parsedStatus}/>

            <ProblemView ast={parsedCalc} />
            <SourceInfoView subject={@props.subject} ast={parsedCalc} />
          </Dialog>
        }
    </span>
