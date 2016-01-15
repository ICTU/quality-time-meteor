@Q = {}

Q.val = (name, val) ->
  num type: 'val', name: name, value: val

num = (val) ->
  node: val
  subtract: (val2) ->
    num binaryOperation 'subtract', val.node or val, val2.node or val2
  add: (val2) ->
    num binaryOperation 'add', val.node or val, val2.node or val2

binaryOperation = (operation, arg1, arg2) ->
  type: 'binaryOperation'
  operation: operation
  arg1: arg1
  arg2: arg2

Q.toJSON = (qObject) ->
  JSON.stringify qObject.node

Q.exec = exec = (qObject) ->
  interpretBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract' then exec(arg1) - exec(arg2)
      else throw "Unsupported operation: #{operation}"

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation' then interpretBinary node
    when 'val' then node.value
    else throw "Unsupported node type: #{node.type}"

Q.explain = explain = (qObject) ->
  explainBinary = ({operation, arg1, arg2}) ->
    switch operation
      when 'subtract' then "#{explain(arg1)} - #{explain(arg2)}"
      else throw "Unsupported operation: #{operation}"

  node = qObject.node or qObject
  switch node.type
    when 'binaryOperation' then explainBinary node
    when 'val' then "#{node.name}(#{node.value})"
    else throw "Unsupported node type: #{node.type}"

q = Q.val('totalCount', 10).subtract(Q.val('failCount', 2)).subtract(Q.val('skipCount', 1)).add(Q.val('addCount', 3))
console.log 'DSL Object', q
console.log 'JSON AST', Q.toJSON q
console.log 'Executed', Q.exec q
console.log 'Explained', Q.explain q
json = Q.toJSON q
console.log 'Executed from JSON AST', Q.exec JSON.parse json
