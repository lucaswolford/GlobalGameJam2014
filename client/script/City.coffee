class Game.City
  width: 0
  height: 0

  constructor: (stage) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("worldbg"))
#    @sprite.anchor.x = 0
#    @sprite.anchor.y = 0
#    @sprite.position.x = @sprite.position.y = 0
    @width = @sprite.texture.width
    @height = @sprite.texture.height
    stage.addChild(@sprite)

  update: ->
    null