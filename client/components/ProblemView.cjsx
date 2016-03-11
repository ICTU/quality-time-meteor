@ProblemView = React.createClass

  render: ->

    collectProblems = (qObject, collector) ->
      collectBinary = ({arg1, arg2}) ->
        collectProblems arg1, collector
        collectProblems arg2, collector
      collectUnary = ({arg}) ->
        collectProblems arg
      collectIf = (node) ->
        collectProblems node.expression, collector
        collectProblems node.then, collector
        collectProblems node.else, collector

      collect = (prop, value, node) ->
        unless collector[node.sourceInfo.id]
          collector[node.sourceInfo.id] = name: node.sourceInfo.name
        collector[node.sourceInfo.id][prop] =
          _.union collector[node.sourceInfo.id][prop] or [], [value]


      collectNoMeasurement = (node) ->
        collect 'noMeasurement', node.name, node
        collect 'error', node.sourceInfo.error, node if node.sourceInfo.error

      node = qObject.node or qObject
      switch node.type
        when 'binaryOperation'  then collectBinary node
        when 'unaryOperation'   then collectUnary node
        when 'if'               then collectIf node
        when 'no_measurement'   then collectNoMeasurement node

    problems = {}
    collectProblems @props.ast, problems

    if Object.keys(problems).length
      <span>
        <h3>Problems</h3>
        <ul>
        {for sourceId of problems
          <li key={sourceId}>{problems[sourceId].name}
          <ul>
            <li>No values for:</li>
            <ul>
              {for prop in problems[sourceId].noMeasurement
                <li key={prop}>{prop}</li>}
            </ul>
            {if problems[sourceId].error
              <li>Errors:
              <ul>
                {for e in problems[sourceId].error
                  <li key={e}>{e}</li>}
              </ul></li>
            }
          </ul></li>
        }
        </ul>
      </span>
    else
      <span />
