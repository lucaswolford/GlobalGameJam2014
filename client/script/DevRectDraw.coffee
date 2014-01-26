class Game.DevRectDraw

  constructor: (stage) ->
    @graphics = new PIXI.Graphics()
    stage.addChild(@graphics)
    stage.interactive = true
    @graphics.beginFill(0xFFFF00)
    @graphics.lineStyle(5, 0xFF0000)

    @rects = []

    stage.mousedown = stage.touchstart = (data) =>
      @dragging = true
      @draggingData = data.global.clone()

    stage.mouseup = stage.mouseupoutside = (data) =>
      @dragging = false
      @graphics.drawRect(@draggingData.x - stage.position.x, @draggingData.y - stage.position.y, data.global.x - @draggingData.x, data.global.y - @draggingData.y)
      @rects.push(
        x1: @draggingData.x - stage.position.x
        y1: @draggingData.y - stage.position.y
        x2: data.global.x - stage.position.x
        y2: data.global.y - stage.position.y
      )
      console.log(@rects)

    stage.mousemove = stage.touchmove = (data) =>
      if @dragging
        null