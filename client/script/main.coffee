stage = new PIXI.Stage(0x000000)

SCREEN_SIZE =
  X: 800
  Y: 600

renderer = PIXI.autoDetectRenderer(SCREEN_SIZE.X, SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

text = new PIXI.Text("Text", {font: "bold italic 14px Arvo", fill: "#eeffee", align: "left", stroke: "#ddeeff", strokeThickness: 1})
text.position.x = 200
text.position.y = 5
text.anchor.x = text.anchor.y = 0
stage.addChild(text)


animate = () ->
  requestAnimFrame( animate )

  renderer.render(stage)

requestAnimFrame( animate )