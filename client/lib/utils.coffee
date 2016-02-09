@Utils =
  capitalize: (text) ->
    [first, rest...] = text
    "#{first.toUpperCase()}#{rest.join('')}"

@T = _i18n.createComponent()
@i18n = (key, params) -> _i18n.__ key, params
