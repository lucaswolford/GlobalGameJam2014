stage = new PIXI.Stage(0x000000)
containerUI = new PIXI.DisplayObjectContainer();
containerWorld = new PIXI.DisplayObjectContainer();
#containerWorld.position.x = containerWorld.position.y = 0;
#containerWorld.scale.x = containerWorld.scale.y = 1;
stage.addChild(containerWorld);
stage.addChild(containerUI);

Game.SCREEN_SIZE =
  X: 800
  Y: 600
Game.SCREEN_SIZE.Xhalf = Game.SCREEN_SIZE.X / 2
Game.SCREEN_SIZE.Yhalf = Game.SCREEN_SIZE.Y / 2

renderer = PIXI.autoDetectRenderer(Game.SCREEN_SIZE.X, Game.SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

input = new Game.InputManager
updater = new Game.UpdateManager(containerWorld, containerUI)

#player = null
assetsLoaded = false

onAssetsLoaded = () ->

  updater.city = new Game.City(containerWorld)

  updater.items.push new Game.Item(400,400, containerWorld)
  updater.items.push new Game.Item(400,500, containerWorld)

  updater.player = new Game.Player(400, 150, containerWorld)
  updater.dialog = new Game.DialogueBox(containerUI)

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
