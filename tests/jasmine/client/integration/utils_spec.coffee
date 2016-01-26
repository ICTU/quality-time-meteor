describe 'Utils', ->
  it '"capitalize" should capitalize the first letter of a string', ->
    expect(Utils.capitalize 'first name').toEqual 'First name'
