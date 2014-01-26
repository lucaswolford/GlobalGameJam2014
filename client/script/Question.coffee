class Game.Question
  selection: 0
  question: null
  active: true
  answer: null

  constructor: (stage, question) ->
    @text = new PIXI.Text("", {font: "bold italic 36px Arvo", fill: "#11FF11", align: "left", stroke: "#22FF00", strokeThickness: 1})
    @text.position.x = 40
    @text.position.y = 10
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)
    @question = question
    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)

  keydown: (event) ->
    if event.keyCode == Game.Key.UP
      @moveUp()
    else if event.keyCode == Game.Key.DOWN
      @moveDown()
    else if event.keyCode == Game.Key.ENTER
      @finalize()

  update: (dt) ->
    @displayAnswers()

  finalize: ->
    @text.setText("a")
    @answer = @selection
    @active = false

  moveUp: ->
    @selection-- if @selection > 0
  moveDown: ->
    @selection++ if @selection < @getAnswers().length - 1

  displayAnswers: ->
    text = ''
    index = 0
    if @active == true
      for answer in @getAnswers()
        if index == @selection
          text += '*' 
        else
          text += ' '
        text += answer + '\n'
        index++
    @text.setText(text)

  getAnswers: ->
    Game.answers[@question]
