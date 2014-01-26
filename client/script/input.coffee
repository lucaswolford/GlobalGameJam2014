Game.Key =
  _pressed: {}

  SPACE: 32
  ENTER: 13
  CTRL: 17
  LEFT: 37
  UP: 38
  RIGHT: 39
  DOWN: 40
  TOUCH: -1

  isDown: (keyCode) ->
    @_pressed[keyCode]

  onKeydown: (event) ->
    @_pressed[event.keyCode] = true

  onKeyup: (event) ->
    delete @_pressed[event.keyCode]

class Game.InputManager
  constructor: (stage) ->
    window.addEventListener('keyup', ((event) -> Game.Key.onKeyup(event) ), false)
    window.addEventListener('keydown', ((event) -> Game.Key.onKeydown(event) ), false)

    stage.interactive = true
    stage.touchdown = stage.mousedown = ->
      Game.Key.onKeydown({keyCode: Game.Key.TOUCH})
    stage.touchend = stage.touchendoutside = stage.mouseup = ->
      Game.Key.onKeyup({keyCode: Game.Key.TOUCH})