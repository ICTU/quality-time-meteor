class @Source
  constructor: (@source, @subject) ->
    @config = _.extend @source, _.omit(@subject, 'id', 'name')

  result: (property) ->
    sourceInfo = _.extend @getInfo(), {id: @config._id}
    if @error then sourceInfo.error = @error
    if @results?[property] isnt undefined
      Q.measurement property, @results[property], sourceInfo
    else Q.noMeasurement property, sourceInfo

  getInfo: ->
    name: @config.name
