@NavigationMenu = React.createClass

  render: ->
    <div id='menu' className="ui fixed menu">
      <div className="ui container">
        <a href="#" className="header item">
          <h1>Quality Time</h1>
        </a>
        <a href="#" className="item">Subjects <i className="dropdown icon"></i></a>
        <div className="ui simple dropdown item">
          Sources <i className="dropdown icon"></i>
          <div className="menu">
            <a className="item" href="#">Link Item</a>
            <a className="item" href="#">Link Item</a>
            <div className="divider"></div>
            <div className="header">Header Item</div>
            <div className="item">
              <i className="dropdown icon"></i>
              Sub Menu
              <div className="menu">
                <a className="item" href="#">Link Item</a>
                <a className="item" href="#">Link Item</a>
              </div>
            </div>
            <a className="item" href="#">Link Item</a>
          </div>
        </div>
      </div>
    </div>
