{ AppBar, LeftNav, MenuItem, FontIcon, Styles } = mui
{ ThemeManager, Colors } = Styles

@MainLayout = React.createClass

  propTypes:
    title: React.PropTypes.string.isRequired
    content: React.PropTypes.func.isRequired

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

          <MenuItem
            leftIcon={<FontIcon className="material-icons" color={Colors.grey500}>dashboard</FontIcon>}
            onTouchTap={@goToRoute '/dashboard'}>
            Dashboard
          </MenuItem>
          <MenuItem
            leftIcon={<FontIcon className="material-icons" color={Colors.grey500}>settings_input_component</FontIcon>}
            onTouchTap={@goToRoute '/sources'}>
            Sources
          </MenuItem>
          <MenuItem
            leftIcon={<FontIcon className="material-icons" color={Colors.grey500}>description</FontIcon>}
            onTouchTap={@goToRoute '/subjects'}>
          Subjects
          </MenuItem>
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
