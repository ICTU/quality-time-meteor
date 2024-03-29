{ Table, TableBody, TableFooter, TableHeader, TableHeaderColumn, TableRow, TableRowColumn } = mui

@CollectionList = React.createClass
  displayName: 'CollectionList'

  propTypes:
    fields: React.PropTypes.array.isRequired
    documents: React.PropTypes.array.isRequired
    onDocumentSelected: React.PropTypes.func

  onTouchTap: (e,x)->
    e.stopPropagation()
    console.log 'button tapped', e, x

  onRowSelection: (rows) ->
    document = @props.documents[rows[0]]
    @props.onDocumentSelected? document

  renderTableRowsColumns: (doc, fields) ->
    fields.map (field, index) ->
      if typeof doc[field] isnt 'object'
        <TableRowColumn key={field}>
          {if index is 0 and doc.icon
            <span>
              <img src={doc.icon} style={height:50} />
              <div style={top: -20, position: 'relative', paddingLeft: 10, display: 'inline-block'}>{doc[field]}</div>
            </span>
          else
            doc[field]
          }
        </TableRowColumn>


    # x.push <TableRowColumn key='buttons'>
    #   <FlatButton secondary={true} label='Add' icon={<ContentAdd />} onTouchTap={@onTouchTap} />
    # </TableRowColumn>
    # x

  tableRows: ->
    @props.documents.map (doc) =>
      <TableRow key={doc._id} className='tableRow'>
        {@renderTableRowsColumns doc, @props.fields}
      </TableRow>

  render: ->
    <Table className='collectionList' headerStyle={height:0, overflow:'hidden'} heigh={300} onRowSelection={@onRowSelection}>
      <TableHeader displaySelectAll={false} adjustForCheckbox={false}>
        <TableRow>
        </TableRow>
      </TableHeader>
      <TableBody showRowHover={true} displayRowCheckbox={false} selectable={false}>
        {@tableRows()}
      </TableBody>
    </Table>
