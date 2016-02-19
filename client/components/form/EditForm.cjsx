{ ClearFix, TextField } = mui

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getInitialState: -> doc: @props.doc
  save: -> @props.onSave? @state.doc
  delete: -> @props.onDelete? @state.doc
  render: ->
    <span>
      <EditFormPart collection={@props.collection} valueLink={@linkState 'doc'}/>
      {@props.customRenderer @linkState('doc') if @props.customRenderer}
    </span>

@EditFormPart = React.createClass
  mixins: [LinkedStateMixin]

  getInitialState: ->
    @props.valueLink.value or {}

  handleChange: (field) -> (e, id, value) =>
    state = {}; state[field] = value
    @setState state

  setState: (newState) ->
    @state = _.extend @state, newState
    @props.valueLink.requestChange @state

  renderEditField: (field, options) ->
    if options?.type.name is 'String'
      opts = options?.autoform?.options
      if opts
        opts = if typeof opts is 'function' then opts() else opts
        <SelectField key={field} value={@state[field]} onChange={@handleChange(field)} floatingLabelText={field}>
          {<MenuItem key={opt.value} value={opt.label} primaryText={opt.label}/> for opt in opts}
        </SelectField>
      else
        <EditField key={field} field={field} valueLink={@linkState field}/>
    else
      console.log 'unknown field type', options.type

  render: ->
    schema = @props.collection.simpleSchema().schema()
    <span>
      {@renderEditField field, options for field, options of schema}
    </span>
