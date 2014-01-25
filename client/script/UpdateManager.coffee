class Game.UpdateManager
  containerWorld: null
  containerUI: null
  dialog: null
  player: null
  city: null
  items: []
  npcs: []
  time: null

  constructor: (containerWorld, containerUI)->
    @containerWorld = containerWorld
    @containerUI = containerUI

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
      @city.update(dt)
      @player.update(dt)
      for item in @items
        item.update(dt)
        if @ifPlayerCollision(item) && (Game.Key.isDown(Game.Key.SPACE))
          item.playerActivated()

      for npc in @npcs
        npc.update(dt)
        if @ifPlayerCollision(npc) && (Game.Key.isDown(Game.Key.SPACE)) && npc.active == false
          npc.playerActivated(@dialog)

    # Scrolling
    @containerWorld.position.x = Game.SCREEN_SIZE.Xhalf - (@player.sprite.position.x)
    @containerWorld.position.y = Game.SCREEN_SIZE.Yhalf - (@player.sprite.position.y)

  ifPlayerCollision: (object) ->
    distX = @player.sprite.position.x - object.sprite.position.x
    distY = @player.sprite.position.y - object.sprite.position.y
    dist = Math.sqrt((distX * distX) + (distY * distY))
    dist <= (@player.size + object.size)
