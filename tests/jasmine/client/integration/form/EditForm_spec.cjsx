TestUtils = React.addons.TestUtils

describe 'EditForm', ->

  source = {}

  beforeEach ->
    source =
      _id: 'TestID1'
      name: 'TestSource1'
      url: 'Test URL 1'
      description: 'test description 1'
      image: 'http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg'

  it 'should display all text inputs', ->
    component = render <EditForm doc={source} fields={['name', 'description', 'url', 'image']}/>
    expect(component.props.children[0].props.children.length).toEqual 4
  it 'should display save button', ->
    component = render <EditForm doc={source} fields={[]}/>
    expect(component.props.children[1].props.children[0].props.label).toEqual 'Save'
  it 'should display delete button', ->
    component = render <EditForm doc={source} fields={[]}/>
    expect(component.props.children[1].props.children[1].props.label).toEqual 'Delete'
  it 'should not display action buttens when showActionButtons is false', ->
    component = render <EditForm doc={source} fields={[]} showActionButtons={false}/>
    expect(component.props.children.length).toEqual 2
    expect(component.props.children[1]).toBe undefined
