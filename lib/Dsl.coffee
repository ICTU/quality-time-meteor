@Q = Q = {}

Q.val = (name, val) ->
  node = type: 'val', name: name, value: val
  switch type = typeof val
    when 'number' then num node
    when 'boolean' then bool node
    else throw "Unsupported value type: #{type}"

Q.if = (val) ->
  type: 'if'
  value: val
  then: (val) -> val
  else: (val) -> val

num = (val1) ->
  node: val1
  subtract: (val) ->
    num binaryOperation 'subtract', val1, val
  add: (val) ->
    num binaryOperation 'add', val1, val
  multiply: (val) ->
    num binaryOperation 'multiply', val1, val
  divide: (val) ->
    num binaryOperation 'divide', val1, val
  equals: (val) ->
    bool binaryOperation 'equals', val1, val

bool = (val1) ->
  node: val1
  not: ->
    bool unaryOperation 'not', val1
  equals: (val) ->
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

Q.toJSON = (qObject) ->
  JSON.stringify qObject.node

Q.exec = exec = (qObject) ->
  interpretBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then exec(arg1) - exec(arg2)
      when 'add'            then exec(arg1) + exec(arg2)
      when 'multiply'       then exec(arg1) * exec(arg2)
      when 'equals'         then exec(arg1) is exec(arg2)
      else                  throw "Unsupported operation: #{operation}"
  interpretUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then !exec(arg)
      else                  throw "Unsupported operation: #{operation}"

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation'  then interpretBinary node
    when 'unaryOperation'   then interpretUnary node
    when 'val'              then node.value
    else                    throw "Unsupported node type: #{node.type}"

Q.explain = explain = (qObject) ->
  explainBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract'       then "#{explain(arg1)} - #{explain(arg2)}"
      when 'add'            then "#{explain(arg1)} + #{explain(arg2)}"
      when 'multiply'       then "#{explain(arg1)} * #{explain(arg2)}"
      else throw "Unsupported operation: #{operation}"
  explainUnary = ({operation, arg}) ->
    switch operation
      when 'not'            then "not(#{exec(arg)})"
      else                  throw "Unsupported operation: #{operation}"

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation'  then explainBinary node
    when 'unaryOperation'   then explainUnary node
    when 'val'              then "#{node.name}(#{node.value})"
    else                    throw "Unsupported node type: #{node.type}"

# q = Q.val('x', true).not().equals(Q.val('y', true))
#
# # q = Q.val('totalCount', 10).subtract(Q.val('failCount', 2))
# # .subtract(Q.val('skipCount', 1))
# .add(Q.val('addCount', 3)).multiply(Q.val('multi', 4))
# console.log 'DSL Object', q
# console.log 'JSON AST', Q.toJSON q
# console.log 'Executed', Q.exec q
# console.log 'Explained', Q.explain q
# json = Q.toJSON q
# console.log 'Executed from JSON AST', Q.exec JSON.parse json
