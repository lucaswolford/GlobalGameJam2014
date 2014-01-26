class Game.DialogueBox
  text: null
  visiblePosition: 0
  index: 0
  textSpeed: 10
  active: true

  constructor: (stage) ->
    @text = new PIXI.Text("Text", {font: "bold italic 36px Arvo", fill: "#110011", align: "left", stroke: "#221100", strokeThickness: 1})
    @text.position.x = 30
    @text.position.y = 10
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)
    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)
    @playScript('detective', 'script')

  update: (dt) ->
    @text.setText(@getGameDialogue()[0..@visiblePosition])
    @visiblePosition += @textSpeed * dt

  keydown: (event) ->
    if event.keyCode == 32
      if not @isAtEndOfLine()
        @displayAll()
      else
        @nextLine()

  displayAll: ->
    @visiblePosition = @getGameDialogue().length

  nextLine: ->
    if @index < Game.dialogue[@npc][@mood].length - 1
      @index++
      @visiblePosition = 0
    else
      @hide()

  isAtEndOfLine: ->
    @visiblePosition >= @getGameDialogue().length

  getGameDialogue: ->
    Game.dialogue[@npc][@mood][@index]

  hide: ->
    @text.setText('')
    @active = false

  playScript: (npc, mood) ->
    @active = true
    @npc = npc
    @mood = mood
    @index = 0
    @visiblePosition = 0
