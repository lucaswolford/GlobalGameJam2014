stage = new PIXI.Stage(0x000000)

SCREEN_SIZE =
  X: 800
  Y: 600

renderer = PIXI.autoDetectRenderer(SCREEN_SIZE.X, SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

input = new Game.InputManager

updater = new Game.UpdateManager

#player = null
assetsLoaded = false

onAssetsLoaded = () ->

  updater.city = new Game.City(stage)
  updater.player = new Game.Player(400, 150, stage)
  updater.dialog = new Game.DialogueBox(stage)

  updater.items.push new Game.Item(400,400, stage)
  updater.items.push new Game.Item(400,450, stage)

  assetsLoaded = true

loader = new PIXI.AssetLoader(['assets/main0.json'])
loader.onComplete = onAssetsLoaded; # use callback
loader.load(); #begin load

animate = () ->
  requestAnimFrame( animate )

#  stage.position.x = player.sprite.position.x if player?
  updater.updateAll() if assetsLoaded == true

  renderer.render(stage)

requestAnimFrame( animate )
