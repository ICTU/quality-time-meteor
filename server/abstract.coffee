#
# Sonar = (subject) ->
#   linesOfCode: ->
#     if subject.sonar.key is 'life?'
#       42
#     else 0
#
# Jenkins = (subject) ->
#   jobSucceeded: -> -1
#
#
# # @Source = (impl) -> (subject) ->
# #   impl subject
#
#
# GameOfLifeApp =
#   sonar: key: 'life?'
# SomeApp =
#   sonar: key: 'some'
#
#
# LOC_Metric = (subject) ->
#   supports: (source) -> !!source.linesOfCode
#   measure: (source) ->
#     source(subject).linesOfCode()
#
#
# #@Measurement =
#
#
# console.log 'measurement', LOC_Metric(GameOfLifeApp).measure Sonar
# console.log 'measurement', LOC_Metric(SomeApp).measure Sonar
# console.log 'measurement', LOC_Metric(SomeApp).supports Jenkins
# console.log 'measurement', LOC_Metric(SomeApp).supports Sonar
#
#
# console.log '====================================='
