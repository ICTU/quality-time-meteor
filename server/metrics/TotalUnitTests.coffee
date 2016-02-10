@TotalUnitTests = class TotalUnitTests
  properties: ['totalUnitTestsCount']
  measure: ({totalUnitTestsCount}) -> totalUnitTestsCount
  status: ({totalUnitTestsCount}) ->
    iff = Q.if totalUnitTestsCount().gt(Q.constant 0)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register 'TotalUnitTests',
    description: 'Shows the total number of unit tests'
    className: 'TotalUnitTests'
