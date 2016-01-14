#
# LOC_Metric = (data) ->
#   date: new Date()
#   value: data.LOC
# Complexity_Metric = (data) ->
#   date: new Date()
#   value: data.Complexity
# FailedJobMetric = (data) ->
#   date: new Date()
#   value: data.FailedJobs
#
# #
# #
# # (subject) {
# #   loc,
# #   complexity,
# #   violations {
# #     criticals,
# #     majors
# #   }
# # }
#
#
# SonarDS = (configuration) ->
#   LOC:
#     if configuration.sonar.key is 'life?'
#       42
#     else 0
#   Complexity: 10
#   Violations:
#     critical: 10
#     major: 5
#
# JenkinsDS = (configuration) ->
#   FailedJobs: 5
#   SuccessfulJobs: 0
#
# CompositeDS = (datasources...) -> (configuration) ->
#   _.reduce datasources, ((l, r) -> _.extend l, r(configuration)), {}
#
#
# GameOfLifeApp =
#   sonar: key: 'life?'
#
# SomeOtherApp =
#   sonar: key: '???'
#
#
# SoftwareDS = CompositeDS SonarDS, JenkinsDS
#
#
# console.log LOC_Metric CDS GameOfLifeApp
# console.log Complexity_Metric Data
# console.log LOC_Metric Data
# console.log FailedJobMetric Data
