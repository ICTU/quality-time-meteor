TestUtils = React.addons.TestUtils

describe 'EditForm', ->

  source = {}

  beforeEach ->
    source =
      name: 'TestSource1'
      url: 'Test URL 1'
      description: 'test description 1'
      image: 'image1.jpg'

  it 'renders a form part with all fields', ->
    component = render <EditForm doc={source} fields={['name', 'description', 'url', 'image']}/>
    expect(component.props.fields.length).toEqual 4
    expect(component.props.valueLink).not.toBe null

  describe 'EditFormPart', ->
    it 'renders all fields', ->
      valueLink =
        value: source
      component = render <EditFormPart fields={['name', 'description', 'url', 'image']} valueLink={valueLink}/>
      expect(component.props.children.length).toBe 4

    it 'renders nested fields', ->
      source =
        name: 'Test'
        jenkins: jobName: 'job1'
      fields = ['name', {'jenkins': ['jobName']}]
      valueLink =
        value: source
      component = render <EditFormPart fields={fields} valueLink={valueLink}/>
      expect(component.props.children.length).toBe 2
      expect(component.props.children[0].props.field).toBe 'name'
      expect(component.props.children[1][0].key).toBe 'jenkins'
      expect(component.props.children[1][0].props.fields.length).toBe 1
      expect(component.props.children[1][0].props.fields[0]).toBe 'jobName'
