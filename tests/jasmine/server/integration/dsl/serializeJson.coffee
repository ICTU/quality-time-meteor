describe 'QDSL', ->
  describe 'AST', ->
    describe 'serialization', ->
      it 'supports serialization to JSON', ->
        val = Q.val 'valueName', 10
        expect(Q.toJSON val).toBe '{"type":"val","name":"valueName","value":10}'
