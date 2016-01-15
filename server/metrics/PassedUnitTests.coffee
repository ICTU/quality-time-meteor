@PassedUnitTests = class PassedUnitTests
  properties: ['passedUnitTestsCount']
  measure: ({passedUnitTestsCount}) -> passedUnitTestsCount

Meteor.startup ->
  MetricTypes.register 'PassedUnitTests',
    description: 'Shows the number of successful unit tests'
    class: PassedUnitTests
