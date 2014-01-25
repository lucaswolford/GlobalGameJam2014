class Game.UpdateManager
  dialog: null
  player: null
  items: []
  time: null

  dt: ->
    now = Date.now()
    dt = (now - (@time || now)) #delta time in ms
    dt *= 0.001 #delta time in sec
    @time = now
    dt

  updateAll: ->
    dt = @dt()
    if @dialog.active
      @dialog.update(dt)
    else
      @player.update(dt)
      for object in @items
        object.update(dt)
        object.playerCollision() if @ifPlayerCollision(object)

  ifPlayerCollision: (object) ->
    distX = @player.sprite.position.x - object.sprite.position.x
    distY = @player.sprite.position.y - object.sprite.position.y
    dist = Math.sqrt((distX * distX) + (distY * distY))
    dist <= (@player.size + object.size)
