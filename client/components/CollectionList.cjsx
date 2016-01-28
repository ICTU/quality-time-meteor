{ Table, TableBody, TableFooter, TableHeader, TableHeaderColumn, TableRow, TableRowColumn } = mui

@CollectionList = React.createClass
  displayName: 'CollectionList'

  propTypes:
    fields: React.PropTypes.array.isRequired
    documents: React.PropTypes.array.isRequired
    onDocumentSelected: React.PropTypes.func

  onRowSelection: (rows) ->
    document = @props.documents[rows[0]]
    @props.onDocumentSelected? document

  renderTableRowsColumns: (doc, fields) ->
    fields.map (field) =>
      if typeof doc[field] isnt 'object'
        <TableRowColumn key={field}>{doc[field]}</TableRowColumn>

  tableRows: ->
    @props.documents.map (doc) =>
      <TableRow key={doc._id}>
        {@renderTableRowsColumns doc, @props.fields}
      </TableRow>

  render: ->
    <Table heigh={300} onRowSelection={@onRowSelection}>
      <TableHeader displaySelectAll={false} adjustForCheckbox={false}>
        <TableRow>
          {@props.fields.map (field) =>
            <TableHeaderColumn key={field}>{field}</TableHeaderColumn>
          }
        </TableRow>
      </TableHeader>
      <TableBody showRowHover={true} displayRowCheckbox={false} selectable={false}>
        {@tableRows()}
      </TableBody>
    </Table>
