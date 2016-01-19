describe 'QDSL', ->
  describe 'Execution', ->
    describe 'numeric', ->

      it 'supports subtraction', ->
        val = Q.val('v1', 10).subtract('v2', 8)
        console.log val


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
