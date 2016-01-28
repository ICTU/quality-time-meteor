{ AppBar, LeftNav, MenuItem, FontIcon, Styles } = mui
{ ThemeManager, Colors } = Styles

@MainLayout = React.createClass

  propTypes:
    title: React.PropTypes.string.isRequired
    content: React.PropTypes.func.isRequired
    currentRoute: React.PropTypes.string.isRequired

  getInitialState: ->
    open: false

  childContextTypes:
    muiTheme: React.PropTypes.object

  getChildContext: ->
    muiTheme: ThemeManager.getMuiTheme()

  onTitleTouchTap: ->
    @setState open: not @state.open
  onLeftIconButtonTouchTap: ->
    @setState open: not @state.open

  goToRoute: (route) -> =>
    @setState open: not @state.open
    FlowRouter.go route

  renderMenuItem: (route, title, icon) ->
    color = if route is @props.currentRoute then '#FF4081'
    <MenuItem style={color:color}
      leftIcon={<FontIcon className="material-icons" color={color}>{icon}</FontIcon>}
      onTouchTap={@goToRoute route} value={route}>
      {title}
    </MenuItem>

  render: ->
    <div>
      <div className='leftSide'>
        <LeftNav ref='leftnav' className='nav' open={true} >
          <AppBar
            className='appBar'
            style={backgroundColor:'white'}
            showMenuIconButton={false}
            title="Quality Time" }
          />
          {[
            @renderMenuItem '/dashboard', 'Dashboard', 'dashboard'
            @renderMenuItem '/sources', 'Sources', 'settings_input_component'
            @renderMenuItem '/subjects', 'Subjects', 'description'
          ]}
        </LeftNav>
      </div>
      <div className='rightSide'>
        <AppBar
          showMenuIconButton={false}
          title={@props.title} />

        <main className='page'>
          {@props.content()}
        </main>
      </div>

    </div>
