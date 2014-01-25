class Game.UpdateManager
  dialog: null
  player: null
  items: []
  npcs: []
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
      for item in @items
        item.update(dt)
        if @ifPlayerCollision(item) && (Game.Key.isDown(Game.Key.ENTER))
          item.playerActivated()

      for npc in @npcs
        npc.update(dt)
        if @ifPlayerCollision(npc) && (Game.Key.isDown(Game.Key.ENTER))
          npc.playerActivated(@dialog)

  ifPlayerCollision: (object) ->
    distX = @player.sprite.position.x - object.sprite.position.x
    distY = @player.sprite.position.y - object.sprite.position.y
    dist = Math.sqrt((distX * distX) + (distY * distY))
    dist <= (@player.size + object.size)
