{ AppBar, LeftNav, MenuItem, FontIcon, Styles} = mui
{ ThemeManager, Colors } = Styles

console.log ThemeManager

@MainLayout = React.createClass

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
      <AppBar
        title="Quality Time"
        iconClassNameRight="muidocs-icon-navigation-expand-more"
        onTitleTouchTap={@onTitleTouchTap}
        onLeftIconButtonTouchTap={@onLeftIconButtonTouchTap}
      />
      <LeftNav ref='leftnav' width={250} open={@state.open} >
        <AppBar
          title="Quality Time"
          onTitleTouchTap={@onTitleTouchTap}
          onLeftIconButtonTouchTap={@onLeftIconButtonTouchTap}
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
        <MenuItem
          leftIcon={<FontIcon className="material-icons" color={Colors.grey500}>gavel</FontIcon>}
          onTouchTap={@goToRoute '/metrics'}>
          Metrics
        </MenuItem>
        <MenuItem
          leftIcon={<FontIcon className="material-icons" color={Colors.grey500}>view_column</FontIcon>}
          onTouchTap={@goToRoute '/source-types'}>
          Source Types
        </MenuItem>
      </LeftNav>

      <main>
        {@props.content()}
      </main>

    </div>
