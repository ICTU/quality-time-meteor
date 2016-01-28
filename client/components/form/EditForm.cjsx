{ ClearFix, TextField } = mui

@EditForm = React.createClass
  displayName: 'EditForm'

  mixins: [LinkedStateMixin]

  getInitialState: -> doc: @props.doc
  save: -> @props.onSave? @state.doc
  delete: -> @props.onDelete? @state.doc
  render: ->
    <EditFormPart fields={@props.fields} valueLink={@linkState 'doc'}/>

@EditFormPart = React.createClass
  mixins: [LinkedStateMixin]

  getInitialState: ->
    @props.valueLink.value

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
