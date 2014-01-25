class Game.DialogueBox
  text: null
  #index of dialogue
  visiblePosition: 0
  index: 0
  textSpeed: 10

  constructor: (stage) ->
    @text = new PIXI.Text("Text", {font: "bold italic 14px Arvo", fill: "#eeffee", align: "left", stroke: "#ddeeff", strokeThickness: 1})
    @text.position.x = 200
    @text.position.y = 5
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)
    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)

  keydown: (event) ->
    if event.keyCode == 32

      if not @isAtEndOfLine()
        @displayAll()
      else
        @nextLine()

  displayAll: ->
    @visiblePosition = @getGameDialogue().length

  nextLine: ->
    if @index < Game.dialogue.length - 1
      @index++
      @visiblePosition = 0

  isAtEndOfLine: ->
    @visiblePosition >= @getGameDialogue().length

  update: (dt) ->
    @text.setText(@getGameDialogue()[0..@visiblePosition])
    @visiblePosition += @textSpeed * dt

  getGameDialogue: ->
    Game.dialogue[@index]

