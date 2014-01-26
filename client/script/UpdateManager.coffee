class Game.UpdateManager
  containerWorld: null
  containerUI: null
  dialog: null
  player: null
  city: null
  items: []
  npcs: []
  time: null

  state: null

  TITLE: 1
  INTERROGATION: 2
  TOPDOWN: 3
  SHOWDOWN: 4
  WRAPUP: 5
  END: 6

  constructor: (containerWorld, containerUI)->
    @containerWorld = containerWorld
    @containerUI = containerUI

  dt: ->
    now = Date.now()
    dt = (now - (@time || now)) #delta time in ms
    dt *= 0.001 #delta time in sec
    @time = now
    dt

  updateGame: ->
    dt = @dt()
    switch @state
      when @TITLE then @updateTitle(dt)
      when @INTERROGATION then @updateInterrogation(dt)
      when @TOPDOWN then @updateTopDown(dt)
      when @SHOWDOWN then @updateShowdowndt(dt)
      when @WRAPUP then @updateWrapUp(dt)
      when @END then @updateEnd(dt)

  ifPlayerCollision: (object) ->
    distX = @player.sprite.position.x - object.sprite.position.x
    distY = @player.sprite.position.y - object.sprite.position.y
    dist = Math.sqrt((distX * distX) + (distY * distY))
    dist <= (@player.size + object.size)

  nextState: ->
    @state++

  updateTitle: (dt) ->
    @nextState if (Game.Key.isDown(Game.Key.SPACE))

  updateInterrogation: (dt) ->
    @dialog.update(dt)
    @nextState if (Game.Key.isDown(Game.Key.SPACE))

  updateTopDown: (dt) ->
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
    @containerWorld.position.x = Game.SCREEN_SIZE.Xhalf - Math.min(Math.max(@player.sprite.position.x,
      Game.SCREEN_SIZE.Xhalf), @city.width - Game.SCREEN_SIZE.Xhalf)
    @containerWorld.position.y = Game.SCREEN_SIZE.Yhalf - Math.min(Math.max(@player.sprite.position.y,
      Game.SCREEN_SIZE.Yhalf), @city.height  - Game.SCREEN_SIZE.Yhalf)


  updateShowdown: (dt) ->
    @dialog.update(dt)

  updateWrapUp: (dt) ->
    @dialog.update(dt)

  updateEnd: (dt) ->
    null
