@TotalUnitTests = class TotalUnitTests
  properties: ['totalUnitTestsCount']
  constants: minimumUnitTestCount: 0
  measure: ({totalUnitTestsCount}) -> totalUnitTestsCount
  status: ({totalUnitTestsCount}, {minimumUnitTestCount}) ->
    iff = Q.if totalUnitTestsCount().gt(Q.constant minimumUnitTestCount or 0)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'TotalUnitTests'
    description: 'Shows the total number of unit tests'
