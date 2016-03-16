@Properties =
  ENABLE_RUNNER: process.env.ENABLE_RUNNER isnt 'false'
  MAX_PARALLEL_JOBS: process.env.MAX_PARALLEL_JOBS or 10
  JOB_SCHEDULER_INTERVAL: process.env.JOB_SCHEDULER_INTERVAL or 10000

console.log "Properties:\n", Properties, "\n\n"
