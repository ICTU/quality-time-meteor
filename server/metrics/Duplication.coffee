class @Duplication extends Metric
  mixins: [AcceptAsTechnicalDebt]
  properties: ['duplication']
  constants: maximumDuplication: 0
  measure: ({duplication}) -> duplication
  status: ({duplication}, {maximumDuplication}) ->
    iff = Q.if duplication().le(Q.constant maximumDuplication)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'Duplication'
    description: 'Shows the percentage of duplication'
