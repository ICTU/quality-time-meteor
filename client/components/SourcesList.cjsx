{ Table, TableBody, TableFooter, TableHeader, TableHeaderColumn, TableRow, TableRowColumn } = mui
{ Styles: { Colors } } = mui

@SourcesList = React.createClass
  displayName: 'SourcesList'

  onRowSelection: (rows) ->
    source = @props.sources[rows[0]]
    FlowRouter.go "/source/#{source._id}/edit"

  tableRows: ->
    @props.sources.map (source) =>
      <TableRow key={source._id}>
        <TableRowColumn>
          <img src={source.icon} style={height:50} />
          <div style={top: -20, position: 'relative', paddingLeft: 10, display: 'inline-block'}>{source.name}</div>
        </TableRowColumn>
        <TableRowColumn>{source.description}</TableRowColumn>
      </TableRow>
  render: ->
    <Table heigh={300} onRowSelection={@onRowSelection}>
      <TableHeader displaySelectAll={false} adjustForCheckbox={false}>
        <TableRow>
          <TableHeaderColumn>Name</TableHeaderColumn>
          <TableHeaderColumn>Description</TableHeaderColumn>
        </TableRow>
      </TableHeader>
      <TableBody showRowHover={true} displayRowCheckbox={false} selectable={false}>
        {@tableRows()}
      </TableBody>
    </Table>
