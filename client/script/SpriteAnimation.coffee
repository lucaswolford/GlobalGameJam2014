# Similar to MovieClip, except this understands delta time
class Game.SpriteAnimation extends PIXI.Sprite
  textures: null
  timePerFrame: 1
  timeUntilNextFrame: 1
  frameCur: 0

  constructor: (textures, timePerFrame) ->
    throw Error("bad arg") if not _.isArray(textures)
    @textures = textures
    @timePerFrame = timePerFrame
    @timeUntilNextFrame = timePerFrame
    super(textures[0])

  # rotate to the next texture when enough time has passed
  update: (dt) ->
    @timeUntilNextFrame -= dt
    if(@timeUntilNextFrame <= 0)
      @timeUntilNextFrame += @timePerFrame # to not re-wait the amount of extra time that has potentially passed
      @frameCur = (@frameCur + 1) % @textures.length
      @setTexture(@textures[@frameCur])