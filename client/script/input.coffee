Game.Key =
  _pressed: {}

  SPACE: 32
  LEFT: 37
  UP: 38
  RIGHT: 39
  DOWN: 40

  isDown: (keyCode) ->
    @_pressed[keyCode]

  onKeydown: (event) ->
    @_pressed[event.keyCode] = true

  onKeyup: (event) ->
    delete @_pressed[event.keyCode]

class Game.InputManager
  init: (window) ->
    window.addEventListener('keyup', ((event) -> Game.Key.onKeyup(event) ), false)
    window.addEventListener('keydown', ((event) -> Game.Key.onKeydown(event) ), false)
