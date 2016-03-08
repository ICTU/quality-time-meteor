{ Dialog , FlatButton } = mui

@SourcesPage = React.createClass
  displayName: 'SourcesPage'
  mixins: [ReactMeteorData]

  getInitialState: ->
    actionHover: false
    popOverTarget: null

  onDocumentSelected: (doc) ->
    FlowRouter.go "/sources/edit/#{doc._id}"

  onTouchTap: ->
    @setState actionHover: not @state.actionHover

  getMeteorData: ->
    sources: Sources.find({}, sort: name: 1).fetch()
    sourceTypes: SourceTypes.find({}, sort: name: 1).fetch()

  handlePopoverClose: ->
    @setState actionHover: false

  onMouseEnter: (event) ->
    @setState
      actionHover: true
      popOverTarget: event.currentTarget

  onListTouchTap: (sourceType) -> ->
    FlowRouter.go "/sources/new/#{sourceType}"

  render: ->
    fields = ['name', 'description']

    <span>
      <Page title='All sources'>
        <Card>
          <CollectionList documents={@data.sources} fields={fields} onDocumentSelected={@onDocumentSelected} />
        </Card>
      </Page>
      <FloatingActionButton
        ref='actionButton'
        style={position:'fixed', right:40, bottom: 40}
        backgroundColor='#483D8B'
        onMouseEnter={@onMouseEnter}
        onTouchTap={@onTouchTap}>
        {if @state.actionHover
          <HardwareDeviceHub />
        else
          <ContentAdd />
        }
      </FloatingActionButton>
      <Popover
        className='sourcesPopover'
        open={@state.actionHover}
        anchorEl={@state.popOverTarget}
        anchorOrigin={horizontal:'right',vertical:'top'}
        targetOrigin={horizontal:'right',vertical:'bottom'}
        onRequestClose={this.handlePopoverClose}
        animation={Popover.PopoverAnimationFromTop}
        style={marginBottom:20}
      >
        <div style={paddingBottom:20}>
          <List className='list'>
            {@data.sourceTypes.map (type) =>
              <ListItem primaryText=type.name leftAvatar={<Avatar src=type.icon />} onTouchTap={@onListTouchTap type.name } />
            }
          </List>
        </div>
      </Popover>
    </span>
    # <ListItem primaryText="Jenkins" leftAvatar={<Avatar src="/images/jenkins/icon.png" />} />
