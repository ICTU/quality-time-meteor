@SubjectMetricDetailPage = React.createClass
  displayName: 'SubjectMetricDetailPage'
  mixins: [ReactMeteorData]

  getMeteorData: ->
    measurement = Measurements.findOne _id: @props.measurementId
    subject: Subjects.findOne name: measurement.forSubject
    measurement: measurement
    comments: Comments.find({metricId: @props.metricId}, {
        sort: created: -1
        transform: (cmt) ->
          userEmail = Meteor.users.findOne(_id: cmt.userId).emails[0].address
          _.extend cmt, avatar: "http://www.gravatar.com/avatar/#{CryptoJS.MD5(userEmail)}"
      }).fetch()

  render: ->
    console.log @props
    console.log @data

    parsedCalc = JSON.parse @data.measurement.calculation
    parsedStatus = JSON.parse @data.measurement.status.calculation

    <Page title={@data.subject.name}>

      <PageElement title='Measurement explanation'>
        <Card>
          <DslHtmlView ast={parsedCalc}/>
        </Card>
      </PageElement>

      <PageElement title='Status explanation'>
        <Card>
          <DslHtmlView ast={parsedStatus}/>
        </Card>
      </PageElement>

      <ProblemView ast={parsedCalc} />

      <PageElement title='Sources'>
        <Card>
          <SourceInfoView subject={@data.subject} ast={parsedCalc} />
        </Card>
      </PageElement>

      <PageElement title='Comments' rightElement={<AddCommentsButton metricId={@props.metricId} />}>
        <Card>
          <CommentsView comments={@data.comments}/>
        </Card>
      </PageElement>
    </Page>

AddCommentsButton = React.createClass
  displayName: 'AddCommentsButton'
  propTypes:
    metricId: React.PropTypes.string.isRequired
  getInitialState: ->
    open: false
  handleCommentsTouchTap: (event) ->
    @setState
      open: true
      anchorEl: event.currentTarget
  handleRequestClose: ->
    @setState open: false
  render: ->
    <span>
      <IconButton onTouchTap={@handleCommentsTouchTap}>
        <CommunicationComment />
      </IconButton>
      <Popover
        open={@state.open}
        anchorEl={@state.anchorEl}
        anchorOrigin={horizontal: 'right', vertical: 'bottom'}
        targetOrigin={horizontal: 'right', vertical: 'top'}
        onRequestClose={@handleRequestClose}
      >
        <div style={padding:10, width:550}>
          <MeteorNewComment metricId={@props.metricId} onCancel={@handleRequestClose} onCommentAdded={@handleRequestClose}/>
        </div>
      </Popover>
    </span>
