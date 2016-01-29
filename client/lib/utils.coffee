@Utils =
  capitalize: (text) ->
    [first, rest...] = text
    "#{first.toUpperCase()}#{rest.join('')}"

@T = _i18n.createComponent()
