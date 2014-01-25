stage = new PIXI.Stage(0x000000)

SCREEN_SIZE =
  X: 800
  Y: 600

renderer = PIXI.autoDetectRenderer(SCREEN_SIZE.X, SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

input = new Game.InputManager(window)
dialogueBox = new Game.DialogueBox(stage)

player = new Game.Player(100,100)
stage.addChild(player.sprite)

time = null
animate = () ->
  requestAnimFrame( animate )

  now = Date.now()
  dt = (now - (time || now)) #delta time in ms
  dt *= 0.001 #delta time in sec
  time = now

  dialogueBox.update(dt)
  player.update(dt)

  renderer.render(stage)

requestAnimFrame( animate )
