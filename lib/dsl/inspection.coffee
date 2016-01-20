unsupportedOperation = (operation) ->
  throw new Error "Unsupported operation: #{operation}"
unsupportedNodeType = (nodeType) ->
  throw new Error "Unsupported node type: #{nodeType}"

Q.explain = explain = (qObject) ->
  explainBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then "#{explain(arg1)} - #{explain(arg2)}"
      when 'add'            then "#{explain(arg1)} + #{explain(arg2)}"
      when 'multiply'       then "#{explain(arg1)} * #{explain(arg2)}"
      when 'divide'         then "#{explain(arg1)} / #{explain(arg2)}"
      when 'equals'         then "#{explain(arg1)} equals #{explain(arg2)}"
      else                  unsupportedOperation operation
  explainUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then "not(#{explain(arg)})"
      else                  throw unsupportedOperation operation
  explainIf = (node) ->
    "if(#{explain node.expression}) then (#{explain node.then})" +
    " else (#{explain node.else})"

  node = qObject.node or qObject
  console.log 'explain', node
  switch node.type
    when 'binaryOperation'  then explainBinary node
    when 'unaryOperation'   then explainUnary node
    when 'if'               then explainIf node
    when 'val'              then "#{node.name}(#{node.value})"
    else                    unsupportedNodeType node.type
