@PassedUnitTests = class PassedUnitTests
  properties: ['passedUnitTestsCount', 'totalUnitTestsCount']
  measure: ({passedUnitTestsCount}) -> passedUnitTestsCount
  status: ({passedUnitTestsCount, totalUnitTestsCount}) ->
    iff = Q.if passedUnitTestsCount().eq(totalUnitTestsCount())
    iff.then Q.val('status', 'ok')
    iff.else Q.val('status', 'nok')

Meteor.startup ->
  MetricTypes.register 'PassedUnitTests',
    description: 'Shows the number of successful unit tests'
    class: PassedUnitTests
