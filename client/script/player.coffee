class Game.Player
  speed: 300
  size: 10
  positionDesired: null

  constructor: (x,y, stage) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)
    @positionDesired = @sprite.position.clone()

  update: (dt) ->
    @moveUp(dt) if (Game.Key.isDown(Game.Key.UP))
    @moveLeft(dt) if (Game.Key.isDown(Game.Key.LEFT))
    @moveDown(dt) if (Game.Key.isDown(Game.Key.DOWN))
    @moveRight(dt) if (Game.Key.isDown(Game.Key.RIGHT))

  moveUp: (dt) ->
    @positionDesired.y -= @speed  * dt

  moveDown: (dt) ->
    @positionDesired.y += @speed  * dt

  moveRight: (dt) ->
    @positionDesired.x += @speed  * dt

  moveLeft: (dt) ->
    @positionDesired.x -= @speed  * dt

  updateCouldMove: (couldMove) ->
    if couldMove
      @sprite.position.x = @positionDesired.x
      @sprite.position.y = @positionDesired.y
    else
      @positionDesired.x = @sprite.position.x
      @positionDesired.y = @sprite.position.y

