describe 'QDSL', ->
  describe 'Inspection', ->
    describe 'numeric', ->

      v1 = Q.val 'v1', 10

      it 'supports subtraction', ->
        expect( Q.explain v1.subtract('v2', 8) ).toBe
        'v1(10) - v2(8)'
      it 'supports addition', ->
        expect( Q.explain v1.add('v2', 8) ).toBe
        'v1(10) + v2(8)'
      it 'supports multiplication', ->
        expect( Q.explain v1.multiply('v2', 8) ).toBe
        'v1(10) * v2(8)'
      it 'supports division', ->
        expect( Q.explain v1.divide('v2', 8) ).toBe
        'v1(10) / v2(8)'
      it 'supports equality', ->
        expect( Q.explain v1.equals('v2', 10) ).toBe
        'v1(10) equals v2(10)'
        expect( Q.explain v1.equals('v2', 2) ).toBe
        'v1(10) equals v2(2)'
      it 'supports less-than', ->
        expect( Q.explain v1.lessThan('v2', 10) ).toBe
        'v1(10) < v2(10)'
      it 'supports less-than-or-equals', ->
        expect( Q.explain v1.lessThan('v2', 10) ).toBe
        'v1(10) <= v2(10)'
      it 'supports greater-than', ->
        expect( Q.explain v1.lessThan('v2', 10) ).toBe
        'v1(10) > v2(10)'
      it 'supports greater-than-or-equals', ->
        expect( Q.explain v1.lessThan('v2', 10) ).toBe
        'v1(10) >= v2(10)'

    describe 'bool', ->

      v1 = Q.val 'v1', true

      it 'supports negation', ->
        expect( Q.explain v1.not() ).toBe
        'not(v1(true))'
      it 'supports equality', ->
        expect( Q.explain v1.equals('v2', false) ).toBe
        'v1(true) equals v2(false)'
        expect( Q.explain v1.equals('v2', true) ).toBe
        'v1(true) equals v2(true)'

    describe 'control', ->
      it 'supports if-then-else', ->
        iff = Q.if('v1', true)
        console.log 'waa', iff
        iff.then(Q.val('v1', 4).add('v2', 2))
        iff.else(Q.val('v1', 4).subtract('v2', 2))
        expect( Q.explain iff).toBe
        'if(v1(true)) then (v1(4) + v2(2)) else (v1(4) - v2(2))'

          # iff = Q.if('v1', false)
          # iff.then(Q.val('v1', 4).add('v2', 2))
          # iff.else(Q.val('v1', 4).subtract('v2', 2))
          # expect( Q.explain iff).toBe ''
          #
          # iff = Q.if Q.val('v1', 4).subtract('v2', 3).equals('v3', 1)
          # iff.then(Q.val('v1', 4).add('v2', 6))
          # expect( Q.explain iff).toBe ''
