styles =
  title:
    float: "right"

@SubjectMeasurement = React.createClass
  displayName: 'SubjectMeasurement'

  getInitialState: ->
    open: false
    comments:
      display: 'none'


  openDialog: (e, metric)->
    @setState open: true

  handleClose: ->
    @setState open: false

  handleCommentsTouchTap: ->
    @setState
      comments:
        display: if @state.comments.display is 'none' then 'block' else 'none'

  render: ->
    m = @props.measurement
    if m
      parsedCalc = JSON.parse m.calculation
      parsedStatus = JSON.parse m.status.calculation

    metric = _.findWhere @props.subject.metrics,
      name: @props.metric.name

    <span>
      <MeasurementListItem
        title={@props.title}
        measurement={m}
        metric={metric}
        onTouchTap={@openDialog} />
        {if m
          <Dialog
            title={
              <div>
                <h2 style={padding: "24px 24px 0 24px"}>{@props.title}
                  <CommunicationComment
                    style={styles.title}
                    onTouchTap={@handleCommentsTouchTap}/>
                </h2>

              </div>
            }
            modal={false}
            open={@state.open}
            onRequestClose={@handleClose}>
            <h3>Value</h3>
            <DslHtmlView ast={parsedCalc}/>
            <h3>Status</h3>
            <DslHtmlView ast={parsedStatus}/>

            <ProblemView ast={parsedCalc} />
            <SourceInfoView subject={@props.subject} ast={parsedCalc} />
            <div style={display: @state.comments.display}>
              <CommentsView {...@props}/>
            </div>
          </Dialog>
        }
    </span>
