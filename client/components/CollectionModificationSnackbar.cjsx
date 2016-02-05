@CollectionModificationSnackbar = React.createClass
  displayName: 'CollectionModificationSnackbar'

  propTypes:
    collection: React.PropTypes.object.isRequired
    itemName: React.PropTypes.string.isRequired

  componentWillMount: ->
    cursor = @props.collection.find {}
    @handle = cursor.observe
      added: (s) => @setState open: true, text: "#{@props.itemName} '#{s.name}' created"
      changed: (n, s) => @setState open: true, text: "#{@props.itemName} '#{s.name}' changed"
      removed: (s) => @setState open: true, text: "#{@props.itemName} '#{s.name}' removed"

  componentWillUnmount: ->
    @handle.stop()

  getInitialState: ->
    open: false
    text: ''

  handleRequestClose: ->
    @setState open: false

  render: ->
    <Snackbar
      open={@state.open}
      message={@state.text}
      autoHideDuration={5000}
      onRequestClose={@handleRequestClose}
    />
