stage = new PIXI.Stage(0x000000)

renderer = PIXI.autoDetectRenderer(800, 600, null)
document.body.appendChild(renderer.view)

animate = () ->
  requestAnimFrame( animate )

  renderer.render(stage)

requestAnimFrame( animate )