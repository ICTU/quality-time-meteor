{ ClearFix, TextField } = mui

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getInitialState: ->
    console.log 'editForm initialState', @props
    doc: @props.doc
  save: -> @props.onSave? @state.doc
  delete: -> @props.onDelete? @state.doc
  render: ->
    <span>
      <EditFormPart fields={@props.fields} valueLink={@linkState 'doc'}/>
      {if @props.customRenderer
        @props.customRenderer @linkState('doc')
      }
    </span>

@EditFormPart = React.createClass
  mixins: [LinkedStateMixin]

  getInitialState: ->
    @props.valueLink.value or {}

  setState: (newState) ->
    @state = _.extend @state, newState
    @props.valueLink.requestChange @state

  renderEditField: (field) ->
    <EditField key={field} field={field} valueLink={@linkState field}/>

  render: ->
    <span>
      {for field in @props.fields
        if (typeof field) isnt 'object'
          @renderEditField field
        else
          for x of field
            <EditFormPart key={x} fields={field[x]} valueLink={@linkState x} />
      }
    </span>
