# { Table, TableBody, TableFooter, TableHeader, TableHeaderColumn, TableRow, TableRowColumn } = mui
# TestUtils = React.addons.TestUtils
# Simulate = TestUtils.Simulate
#
#
# simulateClickOn = (el) ->
#   React.addons.TestUtils.Simulate.click el[0]
#
# describe 'SourcesList', ->
#
#   sources = []
#
#   beforeEach ->
#     sources = [
#       _id: 'TestID1'
#       name: 'TestSource1'
#       description: 'test description 1'
#       image: 'image1.jpg'
#       icon: 'icon1.jpg'
#     ,
#       _id: 'TestID2'
#       name: 'TestSource2'
#       description: 'test description 2'
#       image: 'image2.jpg'
#       icon: 'icon2.jpg'
#     ,
#       _id: 'TestID3'
#       name: 'TestSource3'
#       description: 'test description 3'
#       image: 'image3.jpg'
#       icon: 'icon3.jpg'
#     ]
#
#
#   it 'should display an entry for each source', ->
#     component = render <SourcesList sources={sources} />
#     body = component.props.children[1]
#     expect(body.props.children.length).toEqual 3
#
#   describe 'Source entry', ->
#
#     it 'should display source details', ->
#       component = render <SourcesList sources={sources} />
#       body = component.props.children[1]
#
#       expect(body.props.children[0].props.children).toEqual([
#         <TableRowColumn>
#           <img src='icon1.jpg' style={height:50} />
#           <div style={top: -20, position: 'relative', paddingLeft: 10, display: 'inline-block'}>TestSource1</div>
#         </TableRowColumn>
#         <TableRowColumn>test description 1</TableRowColumn>])
#       expect(body.props.children[1].props.children).toEqual([
#         <TableRowColumn>
#           <img src='icon2.jpg' style={height:50} />
#           <div style={top: -20, position: 'relative', paddingLeft: 10, display: 'inline-block'}>TestSource2</div>
#         </TableRowColumn>
#         <TableRowColumn>test description 2</TableRowColumn>])
#       expect(body.props.children[2].props.children).toEqual([
#         <TableRowColumn>
#           <img src='icon3.jpg' style={height:50} />
#           <div style={top: -20, position: 'relative', paddingLeft: 10, display: 'inline-block'}>TestSource3</div>
#         </TableRowColumn>
#         <TableRowColumn>test description 3</TableRowColumn>])
