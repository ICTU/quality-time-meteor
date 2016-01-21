@TotalUnitTests = class TotalUnitTests
  properties: ['totalUnitTestsCount']
  measure: ({totalUnitTestsCount}) -> totalUnitTestsCount
  status: ({totalUnitTestsCount}) ->
    iff = Q.if totalUnitTestsCount().gt('x', 0)
    iff.then Q.val('status', 'ok')
    iff.else Q.val('status', 'nok')

Meteor.startup ->
  MetricTypes.register 'TotalUnitTests',
    description: 'Shows the total number of unit tests'
    class: TotalUnitTests
