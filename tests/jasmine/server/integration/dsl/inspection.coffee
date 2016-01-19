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
