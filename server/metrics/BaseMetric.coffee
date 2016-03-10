class @Metric
  constructor: ->
    @mixins?.map @_applyMixin.bind @

  _applyMixin: (mixin) ->
    @[field] = mixin[field].bind(@) for field of mixin
