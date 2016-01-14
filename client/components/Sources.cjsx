{ Table, TableBody, TableHeader, TableRow, TableRowColumn, TableHeaderColumn } = mui
{ GridList, GridTile} = mui


@Sources = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    sources: SupportedSources.find().fetch()

  onRowSelection: ->
    console.log 'onRowSelection'

  tiles: ->
    nodes = @data.sources.map (source) =>
      <GridTile
        key={source.name}
        title={source.name}
        subtitle={source.description}>
        <img src={source.img} />
      </GridTile>
    if nodes.length
      nodes
    else
      <span>No data</span>
  # actionIcon={<IconButton><StarBorder color="white"/></IconButton>}

  render: ->
    <span>
      <h1>Supported Sources</h1>
      <GridList
        cellHeight={200}
        cols={3}
        >
        {@tiles()}
      </GridList>
    </span>
# <Table
#   onRowSelection={@onRowSelection}>
#   <TableHeader>
#     <TableRow>
#       <TableHeaderColumn colSpan="3" tooltip='Super Header' style={textAlign: 'center'}>
#         Super Header
#       </TableHeaderColumn>
#     </TableRow>
#     <TableRow>
#       <TableHeaderColumn tooltip='The ID'>ID</TableHeaderColumn>
#       <TableHeaderColumn tooltip='The Name'>Name</TableHeaderColumn>
#       <TableHeaderColumn tooltip='The Status'>Status</TableHeaderColumn>
#     </TableRow>
#   </TableHeader>
#   <TableBody displayRowCheckbox={false}>
#     <TableRow>
#       <TableRowColumn>1</TableRowColumn>
#       <TableRowColumn>John Smith</TableRowColumn>
#       <TableRowColumn>Employed</TableRowColumn>
#     </TableRow>
#   </TableBody>
# </Table>
