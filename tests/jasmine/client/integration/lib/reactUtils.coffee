TestUtils = React.addons.TestUtils

@render = (comp) ->
  renderer = TestUtils.createRenderer()
  console.log renderer, comp
  renderer.render comp
  renderer.getRenderOutput()
