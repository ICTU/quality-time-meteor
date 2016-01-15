{ Table, TableBody, TableHeader, TableRow, TableRowColumn, TableHeaderColumn } = mui
{ GridList, GridTile} = mui


@SourceTypesList = React.createClass

  onRowSelection: ->
    console.log 'onRowSelection'

  createTile: (source) ->
    <GridTile
      key={source.name}
      title={source.name}
      subtitle={source.description}>
      <img src={source.img} />
    </GridTile>

  tiles: ->
    nodes = @props.sources.map (source) => @createTile source
    if nodes.length
      nodes
    else
      <span>No data</span>

  render: ->
    <GridList
      cellHeight={200}
      cols={3}
      >
      {@tiles()}
    </GridList>
