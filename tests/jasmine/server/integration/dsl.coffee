describe 'QDSL', ->
  describe 'AST', ->
    describe 'val', ->
      it 'should support named values', ->
        val = Q.val 'valueName', 10
        expect(val.node.type).toBe 'val'
        expect(val.node.name).toBe 'valueName'
        expect(val.node.value).toBe 10

      describe 'numeric', ->
        it 'supports subtraction', ->
          val = Q.val('v1', 10).subtract(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'subtract'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2

        it 'supports addition', ->
          val = Q.val('v1', 10).add(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'add'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2

        it 'supports multiplication', ->
          val = Q.val('v1', 10).multiply(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'multiply'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2

        it 'supports division', ->
          val = Q.val('v1', 10).divide(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'divide'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
