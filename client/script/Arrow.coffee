class Game.Arrow
  size: 32
  name: null

  constructor: (x,y, stage) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("Arrow"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    @sprite.alpha = 0
    stage.addChild(@sprite)

  appearIn: (time) ->
    _.delay((=> @appear()), time)

  appear: ->
    @sprite.alpha = 1

  update: ->
    null
