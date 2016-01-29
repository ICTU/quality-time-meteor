{ AppBar, LeftNav, MenuItem, FontIcon, Styles } = mui
{ ThemeManager, Colors } = Styles

@MainLayout = React.createClass

  mixins: [_i18n.refreshOnChangeLocaleMixin]

  propTypes:
    title: React.PropTypes.any.isRequired
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
    <MenuItem key={route} style={color:color}
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
            @renderMenuItem '/dashboard', <T>dashboard</T>, 'dashboard'
            @renderMenuItem '/subjects', <T>subjects</T>, 'description'
            @renderMenuItem '/sources', <T>sources</T>, 'settings_input_component'
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
