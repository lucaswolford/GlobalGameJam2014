stage = new PIXI.Stage(0x000000)

SCREEN_SIZE =
  X: 800
  Y: 600

renderer = PIXI.autoDetectRenderer(SCREEN_SIZE.X, SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

input = new Game.InputManager

dialogueBox = new Game.DialogueBox(stage)

player = null
onAssetsLoaded = () ->
  player = new Game.Player(200,150, stage)

loader = new PIXI.AssetLoader(['assets/main0.json'])
loader.onComplete = onAssetsLoaded; # use callback
loader.load(); #begin load

time = null
animate = () ->
  requestAnimFrame( animate )

  now = Date.now()
  dt = (now - (time || now)) #delta time in ms
  dt *= 0.001 #delta time in sec
  time = now

  player.update(dt) if player?
  dialogueBox.update(dt)

  renderer.render(stage)

requestAnimFrame( animate )
