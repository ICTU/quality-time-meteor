Meteor.methods
  'subjects/update': (doc) ->
    metrics = doc.metrics.map (m) ->
      if m.metricId
        SubjectMetrics.update _id: m.metricId, m
      else
        id = SubjectMetrics.insert m
        m.metricId = id
    sources = doc.sources.map (s) ->
      if s.sourceId
        SubjectSources.update _id: s.sourceId, s
      else
        id = SubjectSources.insert s
        s.sourceId = id

    Subjects.upsert _id: doc._id, doc
