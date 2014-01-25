class Game.Npc
  size: 10
  name: null
  mood: null
  active: false

  constructor: (x,y, stage, name, mood) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)
    @name = name
    @mood = mood

  update: ->
    null

  playerActivated: (dialog) ->
    @toggleActive()
    dialog.playScript(@name, @mood)

  toggleActive: ->
    @active = !@active
