@DslHtmlView = React.createClass
  render: ->
    <pre className='ast'>{@renderAst @props.ast}</pre>

  renderAst: (ast) ->
    unsupportedOperation = (operation) ->
      throw new Error "Unsupported operation: #{operation}"
    unsupportedNodeType = (nodeType) ->
      throw new Error "Unsupported node type: #{nodeType}"

    explain  = (qObject) ->
      renderVal = ({name, value}) ->
        <span className='node'>
          <span className='name'>{name}</span>(<span className='value'>{node.value}</span>)
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
          when 'add'            then "#{explain(arg1)} + #{explain(arg2)}"
          when 'multiply'       then "#{explain(arg1)} * #{explain(arg2)}"
          when 'divide'         then "#{explain(arg1)} / #{explain(arg2)}"
          when 'equals'         then "#{explain(arg1)} equals #{explain(arg2)}"
          when 'lessThan'       then "#{explain(arg1)} < #{explain(arg2)}"
          when 'lessEquals'     then "#{explain(arg1)} <= #{explain(arg2)}"
          when 'greaterThan'    then "#{explain(arg1)} > #{explain(arg2)}"
          when 'greaterEquals'  then "#{explain(arg1)} >= #{explain(arg2)}"
          else                  unsupportedOperation operation
      explainUnary = ({operation, arg}) ->
        switch operation
          when 'not'            then "not(#{explain(arg)})"
          else                  throw unsupportedOperation operation
      explainIf = (node) ->
        "if(#{explain node.expression}) then (#{explain node.then})" +
        " else (#{explain node.else})"

      node = qObject.node or qObject
      switch node.type
        when 'binaryOperation'  then explainBinary node
        when 'unaryOperation'   then explainUnary node
        when 'if'               then explainIf node
        when 'val'              then renderVal node
        else                    unsupportedNodeType node.type

    explain ast
