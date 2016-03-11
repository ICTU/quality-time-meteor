class @Complexity extends Metric
  mixins: [AcceptAsTechnicalDebt]
  properties: ['complexity']
  constants: maximumComplexity: 1000
  measure: ({complexity}) -> complexity
  status: ({complexity}, {maximumComplexity}) ->
    iff = Q.if complexity().le(Q.constant maximumComplexity)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'Complexity'
    description: 'Shows the complexity'
