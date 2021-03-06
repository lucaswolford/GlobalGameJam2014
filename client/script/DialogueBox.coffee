class Game.DialogueBox
  text: null
  visiblePosition: 0
  index: 0
  textSpeed: 50
  active: true

  constructor: (stage) ->
#    @sprite = new PIXI.Sprite(Game.getTextureFromFrame("dialogueBox"))
#    @sprite.position.x = 20
#    @sprite.position.y = 20
#    @sprite.alpha = 0.5
#    stage.addChild(@sprite)

    @text = new PIXI.Text("", {font: "bold italic 36px Arvo", fill: "#EEEEEE", align: "left", stroke: "#333333", strokeThickness: 5})
    @text.position.x = 35
    @text.position.y = 10
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)

    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)
    @playScript('detective', 'initial')

  update: (dt) ->
    text = @getGameDialogueSpeaker() + ": \n"
    text += @getGameDialogue()[0..@visiblePosition]
    @text.setText(text)
    @visiblePosition += @textSpeed * dt

  keydown: (event) ->
    if event.keyCode == 32
      if @isAtEndOfLine()
        @nextLine()
      else
        @displayAll()

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

  getGameDialogueSpeaker: ->
    Game.dialogue[@npc][@mood][@index].speaking
  getGameDialogue: ->
    @addNewLines(Game.dialogue[@npc][@mood][@index].text)

  addNewLines: (text) ->
    newLines = text.length / 45
    if newLines > 1
      for index in _.range(1, newLines)
        text = text[0..(index*40)] + '\n' + text[((index*40) + 1)..text.length]
    text

  hide: ->
    @text.setText('')
    @active = false

  playScript: (npc, mood) ->
    @active = true
    @npc = npc
    @mood = mood
    @index = 0
    @visiblePosition = 0
