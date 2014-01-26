class Game.UpdateManager
  containerWorld: null
  containerUI: null
  containerTitle: null
  containerInterro: null
  containerShowdown: null
  containerEnd: null

  dialog: null
  player: null
  city: null
  items: []
  npcs: []
  arrow: null
  time: null
  worldCollisionRects: null

  moodQuestion: null
  actionQuestion: null

  state: null

  TITLE: 1
  INTERROGATION: 2
  TOPDOWN: 3
  SHOWDOWN: 4
  WRAPUP: 5
  END: 6

  constructor: (stage,
                containerWorld,
                containerUI
                containerTitle,
                containerInterro,
                containerShowdown,
                containerEnd
                )->
    @worldCollisionRects = new Game.WorldCollisionRects()
    @stage = stage
    @containerWorld = containerWorld
    @containerUI = containerUI
    @containerTitle = containerTitle
    @containerInterro = containerInterro
    @containerShowdown = containerShowdown
    @containerEnd = containerEnd
    @state = @TITLE
    @switchState()

  dt: ->
    now = Date.now()
    dt = (now - (@time || now)) #delta time in ms
    dt *= 0.001 #delta time in sec
    @time = now
    dt

  switchState: ->
    switch @state
      when @TITLE
        @titleAddAssets()
      when @INTERROGATION
        @titleRemoveAssets()
        @interrogationAddAssets()
      when @TOPDOWN
        @interrogationRemoveAssets()
        @topDownAddAssets()
      when @SHOWDOWN
        @topDownRemoveAssets()
        @showdowndAddAssetst()
      when @WRAPUP
        @showdowndRemoveAssetst()
        @wrapUpAddAssets()
      when @END
        @wrapUpRemoveAssets()
        @endAddAssets()

  updateGame: ->
    dt = @dt()
    switch @state
      when @TITLE then @updateTitle(dt)
      when @INTERROGATION then @updateInterrogation(dt)
      when @TOPDOWN then @updateTopDown(dt)
      when @SHOWDOWN then @updateShowdown(dt)
      when @WRAPUP then @updateWrapUp(dt)
      when @END then @updateEnd(dt)

  ifPlayerCollision: (object) ->
    distX = @player.sprite.position.x - object.sprite.position.x
    distY = @player.sprite.position.y - object.sprite.position.y
    dist = Math.sqrt((distX * distX) + (distY * distY))
    dist <= (@player.size + object.size)

  nextState: ->
    @state++
    @switchState()

  updateTitle: (dt) ->
    @nextState() if (Game.Key.isDown(Game.Key.SPACE) || Game.Key.isDown(Game.Key.TOUCH))

  updateInterrogation: (dt) ->
    if (Game.Key.isDown(Game.Key.ENTER)) &&
        @dialog.active == false &&
        @moodQuestion.active == false
      @nextState()

    if @dialog.active
      @dialog.update(dt)
    else
      @moodQuestion.update(dt)


  updateTopDown: (dt) ->
    if @dialog.active
      @dialog.update(dt)
    else
      @city.update(dt)
      @player.update(dt)
      playerIsColliding = false
      for item in @items
        item.update(dt)
        if @ifPlayerCollision(item) && (Game.Key.isDown(Game.Key.SPACE))
          item.playerActivated()
          @player.hasKnife = true if item.name == 'knife'
          @player.hasPurse = true if item.name == 'purse'

      for npc in @npcs
        npc.update(dt)
        if @ifPlayerCollision(npc) && (Game.Key.isDown(Game.Key.SPACE)) && npc.active == false
          npc.playerActivated(@dialog, @moodQuestion.answer)

      if @worldCollisionRects.isOverDoor(@player.positionDesired.x, @player.positionDesired.y)
        @nextState() if (Game.Key.isDown(Game.Key.SPACE) && @arrow.sprite.alpha == 1)

      # rectangle walls
      playerIsColliding = true if @worldCollisionRects.isPlayerColliding(@player)

      # X boundry
      if @player.positionDesired.x < @player.size || @player.positionDesired.x > @city.width - @player.size
        playerIsColliding = true

      @player.updateCouldMove !playerIsColliding

    # Scrolling
    @containerWorld.position.x = Game.SCREEN_SIZE.Xhalf - Math.min(Math.max(@player.sprite.position.x,
      Game.SCREEN_SIZE.Xhalf), @city.width - Game.SCREEN_SIZE.Xhalf)
    @containerWorld.position.y = Game.SCREEN_SIZE.Yhalf - Math.min(Math.max(@player.sprite.position.y,
      Game.SCREEN_SIZE.Yhalf), @city.height  - Game.SCREEN_SIZE.Yhalf)

  updateShowdown: (dt) ->
    if (Game.Key.isDown(Game.Key.ENTER)) &&
        @dialog.active == false &&
        @actionQuestion.active == false
      @nextState()

    if @dialog.active
      @dialog.update(dt)
    else
      @actionQuestion.update(dt)

  updateWrapUp: (dt) ->
    @dialog.update(dt)
    @nextState() if (Game.Key.isDown(Game.Key.SPACE)) && @dialog.active == false

  updateEnd: (dt) ->
    @nextState() if (Game.Key.isDown(Game.Key.SPACE))


# ASSET LOADING
  titleAddAssets: ->
    @stage.addChild(@containerTitle)
  titleRemoveAssets: ->
    @stage.removeChild(@containerTitle)

  interrogationAddAssets: ->
    @stage.addChild(@containerInterro)
    @stage.addChild(@containerUI)
    @dialog.playScript('detective', 'initial')
    @moodQuestion.active = true
  interrogationRemoveAssets: ->
    @dialog.playScript('detective', @moodQuestion.answer)
    @stage.removeChild(@containerInterro)
    @stage.removeChild(@containerUI)

  topDownAddAssets: ->
    @city.switchBg(@moodQuestion.answer)
    @stage.addChild(@containerWorld)
    @stage.addChild(@containerUI)
    @arrow.appearIn(15000)
  topDownRemoveAssets: ->
    @stage.removeChild(@containerWorld)
    @stage.removeChild(@containerUI)

  showdowndAddAssetst: ->
    @stage.addChild(@containerShowdown)
    @stage.addChild(@containerUI)
    @dialog.playScript('showdown', 'ending')
    @actionQuestion.active = true
    if @player.hasKnife == true
      @actionQuestion.answers.push {value:"stab",   displayText:"used the knife."}
    if @player.hasPurse == true
      @actionQuestion.answers.push {value:"bribe",  displayText:"gave them the purse."}
  showdowndRemoveAssetst: ->
    @stage.removeChild(@containerShowdown)
    @stage.removeChild(@containerUI)

  wrapUpAddAssets: ->
    @stage.addChild(@containerInterro)
    @stage.addChild(@containerUI)
    mood = @moodQuestion.answer
    action = @actionQuestion.answer
    switch mood
      when 'sad'
        switch action
          when 'stab'
            @dialog.playScript('detective', 'sadStab')
          when 'bribe'
            @dialog.playScript('detective', 'sadBribe')
          when 'reason'
            @dialog.playScript('detective', 'sadReason')
          when 'walk'
            @dialog.playScript('detective', 'sadWalk')
      when 'happy'
        switch action
          when 'stab'
            @dialog.playScript('detective', 'happyStab')
          when 'bribe'
            @dialog.playScript('detective', 'happyBribe')
          when 'reason'
            @dialog.playScript('detective', 'happyReason')
          when 'walk'
            @dialog.playScript('detective', 'happyWalk')
      when 'angry'
        switch action
          when 'stab'
            @dialog.playScript('detective', 'angryStab')
          when 'bribe'
            @dialog.playScript('detective', 'angryBribe')
          when 'reason'
            @dialog.playScript('detective', 'angryReason')
          when 'walk'
            @dialog.playScript('detective', 'angryWalk')
  wrapUpRemoveAssets: ->
    @stage.removeChild(@containerInterro)
    @stage.removeChild(@containerUI)

  endAddAssets: ->
    @stage.addChild(@containerEnd)
  endRemoveAssets: ->
    @stage.removeChild(@containerEnd)
