describe 'QDSL', ->
  describe 'Execution', ->
    describe 'numeric', ->

      v1 = Q.val 'v1', 10

      it 'supports subtraction', ->
        expect( Q.exec v1.subtract('v2', 8) ).toBe 2
      it 'supports addition', ->
        expect( Q.exec v1.add('v2', 8) ).toBe 18
      it 'supports multiplication', ->
        expect( Q.exec v1.multiply('v2', 8) ).toBe 80
      it 'supports division', ->
        expect( Q.exec v1.divide('v2', 8) ).toBe 1.25
      it 'supports equality', ->
        expect( Q.exec v1.equals('v2', 10) ).toBe true
        expect( Q.exec v1.equals('v2', 2) ).toBe false
      it 'supports greather-than comparison', ->
        expect( Q.exec v1.gt('v2', 8) ).toBe true
        expect( Q.exec v1.greaterThan('v2', 12) ).toBe false
        expect( Q.exec v1.gt('v2', 10) ).toBe false
      it 'supports greather-than-equals comparison', ->
        expect( Q.exec v1.ge('v2', 8) ).toBe true
        expect( Q.exec v1.greaterEquals('v2', 12) ).toBe false
        expect( Q.exec v1.ge('v2', 10) ).toBe true
      it 'supports less-than comparison', ->
        expect( Q.exec v1.lt('v2', 8) ).toBe false
        expect( Q.exec v1.lessThan('v2', 12) ).toBe true
        expect( Q.exec v1.lt('v2', 10) ).toBe false
      it 'supports less-than-equals comparison', ->
        expect( Q.exec v1.le('v2', 8) ).toBe false
        expect( Q.exec v1.lessEquals('v2', 12) ).toBe true
        expect( Q.exec v1.le('v2', 10) ).toBe true

    describe 'bool', ->

      v1 = Q.val 'v1', true

      it 'supports negation', ->
        expect( Q.exec v1.not() ).toBe false
      it 'supports equality', ->
        expect( Q.exec v1.equals('v2', false) ).toBe false
        expect( Q.exec v1.equals('v2', true) ).toBe true

    describe 'control', ->
      it 'supports if-then-else', ->
        iff = Q.if('v1', true)
        iff.then(Q.val('v1', 4).add('v2', 2))
        iff.else(Q.val('v1', 4).subtract('v2', 2))
        expect( Q.exec iff).toBe 6

        iff = Q.if('v1', false)
        iff.then(Q.val('v1', 4).add('v2', 2))
        iff.else(Q.val('v1', 4).subtract('v2', 2))
        expect( Q.exec iff).toBe 2

        iff = Q.if Q.val('v1', 4).subtract('v2', 3).equals('v3', 1)
        iff.then(Q.val('v1', 4).add('v2', 6))
        expect( Q.exec iff).toBe 10
