unsupportedValueType = (valueType) ->
  throw new Error "Unsupported value type: #{valueType}"

makeVal = (cb) -> (nameOrVal, val) ->
  if (typeof nameOrVal) is 'object'
    cb nameOrVal
  else cb Q.val nameOrVal, val

Q.val = (name, val) ->
  node = type: 'val', name: name, value: val
  switch type = typeof val
    when 'number' then num node
    when 'boolean' then bool node
    else unsupportedValueType type

Q.if = (val) ->
  type: 'if'
  value: val
  then: (val) -> val
  else: (val) -> val

num = (val1) ->
  node: val1
  subtract: makeVal (val) ->
    num binaryOperation 'subtract', val1, val
  add: makeVal (val) ->
    num binaryOperation 'add', val1, val
  multiply: makeVal (val) ->
    num binaryOperation 'multiply', val1, val
  divide: makeVal (val) ->
    num binaryOperation 'divide', val1, val
  equals: makeVal (val) ->
    bool binaryOperation 'equals', val1, val

bool = (val1) ->
  node: val1
  not: ->
    bool unaryOperation 'not', val1
  equals: makeVal (val) ->
    bool binaryOperation 'equals', val1, val

getNode = (val) -> val.node or val
binaryOperation = (operation, arg1, arg2) ->
  type: 'binaryOperation'
  operation: operation
  arg1: getNode arg1
  arg2: getNode arg2

unaryOperation = (operation, arg) ->
  type: 'unaryOperation'
  operation: operation
  arg: getNode arg
