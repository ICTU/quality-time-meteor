describe 'QDSL', ->
  describe 'AST', ->
    describe 'val', ->
      it 'should support named values', ->
        val = Q.val 'valueName', 10
        expect(val.node.type).toBe 'val'
        expect(val.node.name).toBe 'valueName'
        expect(val.node.value).toBe 10
      it 'throws an exception if the value is not supported', ->
        f = -> Q.val('v', 'string')
        expect(f).toThrowError 'Unsupported value type: string'

      expectNumericType = (val) ->
        expect(val.subtract?).toEqual true
        expect(val.add?).toEqual true
        expect(val.multiply?).toEqual true
        expect(val.divide?).toEqual true
        expect(val.equals?).toEqual true

      expectBoolType = (val) ->
        expect(val.not?).toEqual true
        expect(val.equals?).toEqual true

      describe 'numeric', ->
        it 'supports subtraction', ->
          val = Q.val('v1', 10).subtract(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'subtract'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
          expectNumericType val
        it 'supports addition', ->
          val = Q.val('v1', 10).add('v2', 2)
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'add'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
          expectNumericType val
        it 'supports multiplication', ->
          val = Q.val('v1', 10).multiply(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'multiply'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
          expectNumericType val
        it 'supports division', ->
          val = Q.val('v1', 10).divide(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'divide'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
          expectNumericType val
        it 'supports equality', ->
          val = Q.val('v1', 10).equals(Q.val('v2', 2))
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'equals'
          expect(val.node.arg1.value).toBe 10
          expect(val.node.arg2.value).toBe 2
          expectBoolType val

      describe 'bool', ->
        it 'supports negation', ->
          val = Q.val('v1', true).not()
          expect(val.node.type).toBe 'unaryOperation'
          expect(val.node.operation).toBe 'not'
          expect(val.node.arg.value).toBe true
          expectBoolType val
        it 'supports equality', ->
          val = Q.val('v1', true).equals('v2', false)
          expect(val.node.type).toBe 'binaryOperation'
          expect(val.node.operation).toBe 'equals'
          expect(val.node.arg1.value).toBe true
          expect(val.node.arg2.value).toBe false
          expectBoolType val

      describe 'control', ->
        it 'supports if-then-else', ->
          iff = Q.if('v1', true)
          iff.then(Q.val('v1', 4).add('v2', 2))
          iff.else(Q.val('v1', 4).subtract('v2', 2))

          expect(iff.node.type).toBe 'if'
          expect(iff.node.expression.value).toBe true
          expect(iff.node.then.operation).toBe 'add'
          expect(iff.node.else.operation).toBe 'subtract'
