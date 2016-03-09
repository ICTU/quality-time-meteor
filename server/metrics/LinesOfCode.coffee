class @LinesOfCode
  properties: ['linesOfCode']
  constants: maximumLinesOfCode: 50000
  measure: ({linesOfCode}) -> linesOfCode
  status: ({linesOfCode}, {maximumLinesOfCode}) ->
    iff = Q.if linesOfCode().le(Q.constant maximumLinesOfCode)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'LinesOfCode'
    description: 'Shows the lines of code'
