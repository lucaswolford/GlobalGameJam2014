class Game.Player
  speed: 300
  size: 10
  positionDesired: null
  sprites: {}
  curDir: 'down'
  isMoving: false

  constructor: (x,y, stage) ->
    @sprites =
      left: @_prepDirection('playerLeft',x,y,stage)
      right: @_prepDirection('playerRight',x,y,stage)
      up: @_prepDirection('playerUp',x,y,stage)
      down: @_prepDirection('playerDown',x,y,stage)
    @setDir('down')

    @positionDesired = @sprite.position.clone()

  _prepDirection: (baseName,x,y,stage) ->
    @sprite = new Game.SpriteAnimation(Game.getTexturesFromFrameBase(baseName), 0.5)
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.position.x = x
    @sprite.position.y = y
    stage.addChild(@sprite)
    @sprite.alpha = 0
    @sprite

  setDir: (dir) ->
    @sprites[@curDir].alpha = 0
    @sprites[dir].alpha = 1
    @curDir = dir

  update: (dt) ->
    @isMoving = false

    @moveUp(dt) if (Game.Key.isDown(Game.Key.UP)) || (Game.Key.isDown(Game.Key.W))
    @moveLeft(dt) if (Game.Key.isDown(Game.Key.LEFT)) || (Game.Key.isDown(Game.Key.A))
    @moveDown(dt) if (Game.Key.isDown(Game.Key.DOWN)) || (Game.Key.isDown(Game.Key.S))
    @moveRight(dt) if (Game.Key.isDown(Game.Key.RIGHT)) || (Game.Key.isDown(Game.Key.D))

    if @isMoving
      _.each(_.keys(@sprites), ((dir) =>
        @sprites[dir].update(dt)
      ))

  moveUp: (dt) ->
    @setDir('up')
    @isMoving = true
    @positionDesired.y -= @speed  * dt

  moveDown: (dt) ->
    @setDir('down')
    @isMoving = true
    @positionDesired.y += @speed  * dt

  moveRight: (dt) ->
    @setDir('right')
    @isMoving = true
    @positionDesired.x += @speed  * dt

  moveLeft: (dt) ->
    @setDir('left')
    @isMoving = true
    @positionDesired.x -= @speed  * dt

  updateCouldMove: (couldMove) ->
    if couldMove
      _.each(_.keys(@sprites), ((dir) =>
        @sprites[dir].position.x = @positionDesired.x
        @sprites[dir].position.y = @positionDesired.y
      ))
    else
      @positionDesired.x = @sprite.position.x
      @positionDesired.y = @sprite.position.y

