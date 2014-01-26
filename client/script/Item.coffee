class Game.Item
  size: 32
  name: null

  constructor: (x,y, stage, name) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("item"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)
    @name = name

  update: ->
    null

  playerActivated: ->
    @sprite.position.x = -1000
    #add to player inventory
