class @CodeCoverage extends Metric
  mixins: [AcceptAsTechnicalDebt]
  properties: ['codeCoverage']
  constants: minimumCodeCoverage: 80
  measure: ({codeCoverage}) -> codeCoverage
  status: ({codeCoverage}, {minimumCodeCoverage}) ->
    iff = Q.if codeCoverage().ge(Q.constant minimumCodeCoverage)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'CodeCoverage'
    description: 'Shows the unit tests code coverage'
