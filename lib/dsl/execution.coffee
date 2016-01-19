Q.exec = exec = (qObject) ->
  interpretBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then exec(arg1) - exec(arg2)
      when 'add'            then exec(arg1) + exec(arg2)
      when 'multiply'       then exec(arg1) * exec(arg2)
      when 'equals'         then exec(arg1) is exec(arg2)
      else                  unsupportedOperation operation
  interpretUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then not exec(arg)
      else                  unsupportedOperation operation

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation'  then interpretBinary node
    when 'unaryOperation'   then interpretUnary node
    when 'val'              then node.value
    else                    unsupportedNodeType node.type

Q.explain = explain = (qObject) ->
  explainBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then "#{explain(arg1)} - #{explain(arg2)}"
      when 'add'            then "#{explain(arg1)} + #{explain(arg2)}"
      when 'multiply'       then "#{explain(arg1)} * #{explain(arg2)}"
      else                  unsupportedOperation operation
  explainUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then "not(#{exec(arg)})"
      else                  throw unsupportedOperation operation

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation'  then explainBinary node
    when 'unaryOperation'   then explainUnary node
    when 'val'              then "#{node.name}(#{node.value})"
    else                    unsupportedNodeType node.type
