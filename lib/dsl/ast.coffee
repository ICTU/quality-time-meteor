unsupportedValueType = (valueType) ->
  throw new Error "Unsupported value type: #{valueType}"

makeVal = (cb) -> (nameOrVal, val) ->
  if (typeof nameOrVal) is 'object'
    cb nameOrVal
  else cb Q.val nameOrVal, val

getNode = (val) -> val.node or val

Q.val = (name, val) ->
  node = type: 'val', name: name, value: val
  switch type = typeof val
    when 'number'   then num node
    when 'boolean'  then bool node
    when 'string'   then string node
    else unsupportedValueType type

Q.if = makeVal (val) ->
  x =
    node:
      type: 'if'
      expression: getNode val
    then: makeVal (val) -> x.node.then = getNode val; x
    else: makeVal (val) -> x.node.else = getNode val; x

num = (val1) ->
  node: val1
  subtract: minus =  makeVal (val) ->
    num binaryOperation 'subtract', val1, val
  minus: minus
  add: plus = makeVal (val) ->
    num binaryOperation 'add', val1, val
  plus: plus
  multiply: times =  makeVal (val) ->
    num binaryOperation 'multiply', val1, val
  times: times
  divide: div = makeVal (val) ->
    num binaryOperation 'divide', val1, val
  div: div
  equals: eq = makeVal (val) ->
    bool binaryOperation 'equals', val1, val
  eq: eq
  greaterEquals: ge = makeVal (val) ->
    bool binaryOperation 'greaterEquals', val1, val
  ge: ge
  greaterThan: gt = makeVal (val) ->
    bool binaryOperation 'greaterThan', val1, val
  gt: gt
  lessEquals: le = makeVal (val) ->
    bool binaryOperation 'lessEquals', val1, val
  le: le
  lessThan: lt = makeVal (val) ->
    bool binaryOperation 'lessThan', val1, val
  lt: lt

bool = (val1) ->
  node: val1
  not: ->
    bool unaryOperation 'not', val1
  equals: makeVal (val) ->
    bool binaryOperation 'equals', val1, val

string = (val1) ->
  node: val1
  equals: eq = makeVal (val) ->
    bool binaryOperation 'equals', val1, val

binaryOperation = (operation, arg1, arg2) ->
  type: 'binaryOperation'
  operation: operation
  arg1: getNode arg1
  arg2: getNode arg2

unaryOperation = (operation, arg) ->
  type: 'unaryOperation'
  operation: operation
  arg: getNode arg
