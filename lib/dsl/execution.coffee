unsupportedOperation = (operation) ->
  throw new Error "Unsupported operation: #{operation}"
unsupportedNodeType = (nodeType) ->
  throw new Error "Unsupported node type: #{nodeType}"

Q.exec = exec = (qObject) ->
  interpretBinary = ({operation, arg1, arg2}) ->
    val1 = exec(arg1)
    val2 = exec(arg2)
    return undefined if (val1 or val2) is undefined

    switch operation
      when 'subtract'       then val1 - val2
      when 'add'            then val1 + val2
      when 'multiply'       then val1 * val2
      when 'divide'         then val1 / val2
      when 'equals'         then val1 is val2
      when 'lessThan'       then val1 < val2
      when 'lessEquals'     then val1 <= val2
      when 'greaterThan'    then val1 > val2
      when 'greaterEquals'  then val1 >= val2
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
    when 'constant'         then node.value
    when 'measurement'      then node.value
    when 'no_measurement'   then undefined
    else                    unsupportedNodeType node.type
