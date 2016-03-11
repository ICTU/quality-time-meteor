class @Violations extends Metric
  mixins: [AcceptAsTechnicalDebt]
  properties: ['violations']
  constants: allowedViolations: 10
  measure: ({violations}) -> violations
  status: ({violations}, {allowedViolations}) ->
    iff = Q.if violations().le(Q.constant allowedViolations)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'Violations'
    description: 'Shows the total number of violations'
