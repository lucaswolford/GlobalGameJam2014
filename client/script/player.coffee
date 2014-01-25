class Game.Player
  speed: 10
  constructor: (x,y) ->
    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"))
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y

  update: (dt) ->
    @moveUp(dt) if (Game.Key.isDown(Game.Key.UP))
    @moveLeft(dt) if (Game.Key.isDown(Game.Key.LEFT))
    @moveDown(dt) if (Game.Key.isDown(Game.Key.DOWN))
    @moveRight(dt) if (Game.Key.isDown(Game.Key.RIGHT))

  moveUp: (dt) ->
    @sprite.position.y -= @speed  * dt

  moveDown: (dt) ->
    @sprite.position.y += @speed  * dt

  moveRight: (dt) ->
    @sprite.position.x += @speed  * dt

  moveLeft: (dt) ->
    @sprite.position.x -= @speed  * dt
