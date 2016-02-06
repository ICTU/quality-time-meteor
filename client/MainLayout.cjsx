{ AppBar, LeftNav, MenuItem, FontIcon, Styles } = mui
{ ThemeManager, Colors } = Styles

@MainLayout = React.createClass

  mixins: [_i18n.refreshOnChangeLocaleMixin, ReactMeteorData]

  propTypes:
    title: React.PropTypes.any.isRequired
    content: React.PropTypes.func.isRequired
    currentRoute: React.PropTypes.string.isRequired

  getMeteorData: ->
    user: Meteor.user()

  getInitialState: ->
    open: true

  childContextTypes:
    muiTheme: React.PropTypes.object

  getChildContext: ->
    muiTheme: ThemeManager.getMuiTheme()

  onLeftIconButtonTouchTap: ->
    @setState open: not @state.open

  goToRoute: (route) -> =>
    FlowRouter.go route

  renderMenuItem: (route, title, icon, iconColor) ->
    color = if route is @props.currentRoute then 'black' else '#676461'
    fontWeight = if route is @props.currentRoute then 400 else 100
    bgColor = if route is @props.currentRoute then '#E7E7E7' else '#F2F2F2'
    <ListItem key={route} style={color:color, backgroundColor:bgColor, fontWeight:fontWeight, fontSize:14} value={route}
      leftIcon={<FontIcon className="material-icons" color={iconColor}>{icon}</FontIcon>}
      onTouchTap={@goToRoute route} value={route}>
      {title}
    </ListItem>

  render: ->
    <div>
      <AppBar
        className='appBar'
        showMenuIconButton={true}
        onLeftIconButtonTouchTap={@onLeftIconButtonTouchTap}
        title={@props.title}
        iconElementRight={if @data.user
          <IconMenu
            iconButtonElement={<IconButton className='userMenu' style={marginRight:20}><Avatar src={"http://www.gravatar.com/avatar/#{CryptoJS.MD5(Meteor.user().emails[0].address).toString()}"}
              size={50}  /></IconButton>}
            anchorOrigin={{horizontal: 'right', vertical: 'top'}}
            targetOrigin={{horizontal: 'right', vertical: 'top'}}
          >
            <MenuItem primaryText="My Account" onClick={-> FlowRouter.go 'account'} />
            <Divider />
            <MenuItem primaryText="Sign out" onClick={Meteor.logout} />
          </IconMenu>
        else
          <FlatButton label="Login" linkButton={true} href="/login" />
        }
        >

      </AppBar>
      <div className='container'>
        <div className='leftSide'>
          {if @data.user
            <LeftNav ref='leftnav' className='nav' open={@state.open} >
              <List className='list' value={@props.currentRoute}>
                {[
                  @renderMenuItem '/dashboard', <T>dashboard</T>, 'dashboard', '#4285F4'
                  @renderMenuItem '/subjects', <T>subjects</T>, 'description', '#795548'
                  @renderMenuItem '/sources', <T>sources</T>, 'device_hub', '#3FAF79'
                ]}
              </List>
            </LeftNav>
          }
        </div>
        <main className='main'>
          {@props.content()}
        </main>
        <div className='rightSide'>
        </div>
      </div>

      <CollectionModificationSnackbar collection={Subjects} itemName='Subject' />
      <CollectionModificationSnackbar collection={Sources} itemName='Source' />
    </div>
