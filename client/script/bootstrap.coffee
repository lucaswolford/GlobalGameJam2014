window.Game = {}

# Helper function to either get texture from SpriteSheet loaded cache, or undefined
Game.getTextureFromFrame = (frameId, unsafe) ->
  name = frameId+'.png'
  if unsafe?
    return PIXI.TextureCache[name] || null
  else
    return PIXI.TextureCache[name] || PIXI.Texture.fromImage name

# Gets textures 1..n with that base name, ex: A -> A1,A2,A3
Game.getTexturesFromFrameBase = (frameBase) ->
  textures = []
  result = null
  index = 0
  loop
    index++
    result = Game.getTextureFromFrame(frameBase+index, true)
    if result?
      textures.push(result)
    else
      break

  textures
