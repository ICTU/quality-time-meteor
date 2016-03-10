class @ReadyUserStories extends Metric
  mixins: [AcceptAsTechnicalDebt]
  properties: ['readyUserStories']
  constants: minimumStories: 0
  measure: ({readyUserStories}) -> readyUserStories
  status: ({readyUserStories}, {minimumStories}) ->
    iff = Q.if readyUserStories().ge(Q.constant minimumStories)
    iff.then Q.constant 'ok'
    iff.else Q.constant 'nok'

Meteor.startup ->
  MetricTypes.register
    name: 'ReadyUserStories'
    description: 'Shows ready user stories'
