@TotalUnitTests = class TotalUnitTests
  properties: ['totalUnitTestsCount']
  measure: ({totalUnitTestsCount}) -> totalUnitTestsCount

Meteor.startup ->
  MetricTypes.register 'TotalUnitTests',
    description: 'Shows the total number of unit tests'
    class: TotalUnitTests
