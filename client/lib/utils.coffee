@Utils =
  capitalize: (text) ->
    [first, rest...] = text
    "#{first.toUpperCase()}#{rest.join('')}"
