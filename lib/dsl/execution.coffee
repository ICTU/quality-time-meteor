unsupportedOperation = (operation) ->
  throw new Error "Unsupported operation: #{operation}"
unsupportedNodeType = (nodeType) ->
  throw new Error "Unsupported node type: #{nodeType}"

Q.exec = exec = (qObject) ->
  interpretBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then exec(arg1) - exec(arg2)
      when 'add'            then exec(arg1) + exec(arg2)
      when 'multiply'       then exec(arg1) * exec(arg2)
      when 'divide'         then exec(arg1) / exec(arg2)
      when 'equals'         then exec(arg1) is exec(arg2)
      else                  unsupportedOperation operation
  interpretUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then not exec(arg)
      else                  unsupportedOperation operation
  interpretIf = (node) ->
    if exec(node.expression) is true
      exec node.then
    else exec node.else

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation'  then interpretBinary node
    when 'unaryOperation'   then interpretUnary node
    when 'if'               then interpretIf node
    when 'val'              then node.value
    else                    unsupportedNodeType node.type
