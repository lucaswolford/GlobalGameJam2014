class Game.City

  constructor: (stage) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("worldbg"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = @sprite.position.y = 0
    stage.addChild(@sprite)

  update: ->
    null