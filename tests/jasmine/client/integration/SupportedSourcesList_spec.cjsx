TestUtils = React.addons.TestUtils
Simulate = TestUtils.Simulate
{ GridList, GridTile} = mui

render = (comp) ->
  renderer = TestUtils.createRenderer()
  console.log renderer, comp
  renderer.render comp
  renderer.getRenderOutput()

simulateClickOn = (el) ->
  React.addons.TestUtils.Simulate.click el[0]

describe 'SupportedSourcesList', ->

  sources = []

  beforeEach ->
    sources = [
      name: 'TestSource1'
      description: 'test description 1'
      img: 'http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg'
    ,
      name: 'TestSource2'
      description: 'test description 2'
      img: 'http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg'
    ]

  it 'should display a message when there is no data', ->
    component = render <SupportedSourcesList sources={[]} />
    expect(component.props.children).toEqual <span>No data</span>

  it 'should display a tile for each source', ->
    component = render <SupportedSourcesList sources={sources} />
    expect(component.props.children.length).toEqual 2

  describe 'Tiles', ->

    it 'should display source details', ->
      component = render <SupportedSourcesList sources={sources} />

      expect(component.props.children).toEqual([
        <GridTile
          key='TestSource1'
          title='TestSource1'
          subtitle='test description 1'>
          <img src='http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg' />
        </GridTile>
        <GridTile
          key='TestSource2'
          title='TestSource2'
          subtitle='test description 2'>
          <img src='http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg' />
        </GridTile>])

      expect(component.props.children).toContain(
        <GridTile
          key='TestSource2'
          title='TestSource2'
          subtitle='test description 2'>
          <img src='http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg' />
        </GridTile>)
