@PassedUnitTests = class PassedUnitTests
  properties: ['passedUnitTestsCount', 'totalUnitTestsCount']
  measure: ({passedUnitTestsCount}) -> passedUnitTestsCount
  status: ({passedUnitTestsCount, totalUnitTestsCount}) ->
    iff = Q.if passedUnitTestsCount().eq(totalUnitTestsCount())
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    description: 'Shows the number of successful unit tests'
    name: 'PassedUnitTests'
