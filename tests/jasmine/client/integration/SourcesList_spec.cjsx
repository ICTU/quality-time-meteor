TestUtils = React.addons.TestUtils
Simulate = TestUtils.Simulate
{ GridList, GridTile} = mui


simulateClickOn = (el) ->
  React.addons.TestUtils.Simulate.click el[0]

describe 'SourcesList', ->

  sources = []

  beforeEach ->
    sources = [
      _id: 'TestID1'
      name: 'TestSource1'
      description: 'test description 1'
      image: 'http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg'
    ,
      _id: 'TestID2'
      name: 'TestSource2'
      description: 'test description 2'
      image: 'http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg'
    ]

  it 'should display a message when there is no data', ->
    component = render <SourcesList sources={[]} />
    expect(component.props.children).toEqual <span>No data</span>

  it 'should display a tile for each source', ->
    component = render <SourcesList sources={sources} />
    expect(component.props.children.length).toEqual 2

  describe 'Tiles', ->

    it 'should display source details', ->
      component = render <SourcesList sources={sources} />

      expect(component.props.children).toEqual([
        <GridTile
          key='TestSource1'
          title='TestSource1'
          subtitle='test description 1'>
          <a href='/source/TestID1/edit'>
            <img src='http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg' />
          </a>
        </GridTile>
        <GridTile
          key='TestSource2'
          title='TestSource2'
          subtitle='test description 2'>
          <a href='/source/TestID2/edit'>
            <img src='http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg' />
          </a>
        </GridTile>])
