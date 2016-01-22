TestUtils = React.addons.TestUtils

@render = (comp) ->
  renderer = TestUtils.createRenderer()
  renderer.render comp
  renderer.getRenderOutput()
