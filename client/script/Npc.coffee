class Game.Npc
  size: 50
  name: null
  mood: null
  active: false

  constructor: (x,y, stage, name) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("NPC_"+name))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)
    @name = name

  update: ->
    null

  playerActivated: (dialog, mood) ->
    @toggleActive()
    dialog.playScript(@name, mood)

  toggleActive: ->
    @active = !@active
