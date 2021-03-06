stage = new PIXI.Stage(0x000000)

containerUI = new PIXI.DisplayObjectContainer()
containerWorld = new PIXI.DisplayObjectContainer()
containerTitle = new PIXI.DisplayObjectContainer()
containerInterro = new PIXI.DisplayObjectContainer()
containerInterro2 = new PIXI.DisplayObjectContainer()
containerShowdown = new PIXI.DisplayObjectContainer()
containerEnd = new PIXI.DisplayObjectContainer()

Game.SCREEN_SIZE =
  X: 800
  Y: 600
Game.SCREEN_SIZE.Xhalf = Game.SCREEN_SIZE.X / 2
Game.SCREEN_SIZE.Yhalf = Game.SCREEN_SIZE.Y / 2

renderer = PIXI.autoDetectRenderer(Game.SCREEN_SIZE.X, Game.SCREEN_SIZE.Y, null)
document.body.appendChild(renderer.view)

input = new Game.InputManager(stage)
updater = new Game.UpdateManager(stage,
                                 containerWorld,
                                 containerUI,
                                 containerTitle,
                                 containerInterro,
                                 containerInterro2,
                                 containerShowdown,
                                 containerEnd )

#player = null
assetsLoaded = false

onAssetsLoaded = () ->
#title
  title = new PIXI.Sprite(Game.getTextureFromFrame("titleScreen"))
  containerTitle.addChild(title)
#interro
  interroBg = new PIXI.Sprite(Game.getTextureFromFrame("interrogation"))
  detective = new Game.SpriteAnimation(Game.getTexturesFromFrameBase("Detective Pose "), 5)
  prot = new PIXI.Sprite(Game.getTextureFromFrame("protg neutral"))
  updater.detective = detective
  updater.prot = prot
  containerInterro.addChild(interroBg)
  containerInterro.addChild(detective)
  containerInterro.addChild(prot)
  updater.moodQuestion = new Game.Question(containerUI, 'mood')

#interro2
  containerInterro2.addChild(interroBg)
  containerInterro2.addChild(detective)
  containerInterro2.addChild(prot)

#topdown
  updater.city = new Game.City(containerWorld)
  updater.items.push new Game.Item(270,460, containerWorld, 'knife')
  updater.items.push new Game.Item(1260,470, containerWorld, 'purse')
  updater.dialog = new Game.DialogueBox(containerUI)
  updater.arrow = new Game.Arrow(463,580, containerWorld)
  updater.npcs.push new Game.Npc(960,430, containerWorld, 'hobo')
  updater.npcs.push new Game.Npc(680,430, containerWorld, 'bystander')
  updater.player = new Game.Player(463, 460, containerWorld)
  updater.npcs.push new Game.Npc(1180,680, containerWorld, 'victim')
#showdown
  showdownBg = new PIXI.Sprite(Game.getTextureFromFrame("showdown"))
  containerShowdown.addChild(showdownBg)
  updater.actionQuestion = new Game.Question(containerUI, 'action')

#wrapup
  wrapupBg = new PIXI.Sprite(Game.getTextureFromFrame("interrogation"))
  containerInterro.addChild(wrapupBg)
#end
  endBg = new PIXI.Sprite(Game.getTextureFromFrame("end"))
  containerEnd.addChild(endBg)

#  new Game.DevRectDraw(containerWorld)

  assetsLoaded = true

loader = new PIXI.AssetLoader(['assets/main0.json'])
loader.onComplete = onAssetsLoaded # use callback
loader.load() #begin load

animate = () ->
  requestAnimFrame( animate )

  updater.updateGame() if assetsLoaded == true

  renderer.render(stage)

requestAnimFrame( animate )
