class Game.Item
  size: 10

  constructor: (x,y, stage) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("item"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)

  update: ->
    null

  playerActivated: ->
    @sprite.position.x = -1000
    #add to player inventory
