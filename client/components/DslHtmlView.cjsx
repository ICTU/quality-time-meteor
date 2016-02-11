@DslHtmlView = React.createClass
  handleClose: ->
    @setState open: false

  open: ->
    @setState open: true

  render: ->
    <Dialog
      title={@props.title}
      modal={false}
      open={@state.open}
      onRequestClose={@handleClose}>
      <h3>Value</h3>
      <pre className='ast'>{@renderAst @props.ast}</pre>
      <h3>Status</h3>
      <pre className='ast'>{@renderAst @props.statusAst}</pre>
      <ProblemView ast={@props.ast} />
    </Dialog>

  getInitialState: ->
    open: false

  renderAst: (ast) ->
    unsupportedOperation = (operation) ->
      throw new Error "Unsupported operation: #{operation}"
    unsupportedNodeType = (nodeType) ->
      throw new Error "Unsupported node type: #{nodeType}"

    explain  = (qObject) ->

      renderConstant = ({value}) ->
        <span className='node constant'>{value}</span>

      renderNoMeasurement = ({name}) ->
        <span className='node noMeasurement'>{name}</span>

      renderMeasurement = ({name, value}) ->
        <span className='node measurement'>
          <span className='name'>{name}</span>(<span className='value'>{value}</span>)
        </span>
      renderBinary = (arg1, arg2, operator) ->
        <span className='node'>
          <span className='arg'>{explain arg1}</span>
          &nbsp;<span className='operator'>{operator}</span>&nbsp;
          <span className='arg'>{explain arg2}</span>
        </span>

      explainBinary = ({operation, arg1, arg2}) ->
        switch operation
          when 'subtract'       then renderBinary arg1, arg2, '-'
          when 'add'            then renderBinary arg1, arg2, '+'
          when 'multiply'       then renderBinary arg1, arg2, '*'
          when 'divide'         then renderBinary arg1, arg2, '/'
          when 'equals'         then renderBinary arg1, arg2, '=='
          when 'lessThan'       then renderBinary arg1, arg2, '<'
          when 'lessEquals'     then renderBinary arg1, arg2, '<='
          when 'greaterThan'    then renderBinary arg1, arg2, '>'
          when 'greaterEquals'  then renderBinary arg1, arg2, '>='
          else                  unsupportedOperation operation
      explainUnary = ({operation, arg}) ->
        switch operation
          when 'not'            then "not(#{explain(arg)})"
          else                  throw unsupportedOperation operation
      explainIf = (node) ->
        <span className='controlFlow'><span className='if'>if</span> {explain node.expression}
          <span className='thenClause'>{explain node.then}</span>
          <span className='else'>else</span>
          <span className='elseClause'>{explain node.else}</span>
        </span>

      node = qObject.node or qObject
      switch node.type
        when 'binaryOperation'  then explainBinary node
        when 'unaryOperation'   then explainUnary node
        when 'if'               then explainIf node
        when 'constant'         then renderConstant node
        when 'measurement'      then renderMeasurement node
        when 'no_measurement'   then renderNoMeasurement node
        else                    unsupportedNodeType node.type

    explain ast
