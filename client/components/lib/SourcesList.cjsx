{ GridList, GridTile} = mui

@SourcesList = React.createClass
  displayName: 'SourcesList'

  onRowSelection: ->
    console.log 'onRowSelection'

  createTile: (source) ->
    <GridTile
      key={source.name}
      title={source.name}
      subtitle={source.description}>
      <a href={"/source/#{source._id}/edit"}>
        <img src={source.image} />
      </a>
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
