class Game.Question
  selection: 0
  question: null
  active: false
  answer: null
  answers: null

  constructor: (stage, question) ->
    @text = new PIXI.Text("", {font: "bold italic 36px Arvo", fill: "#EEEEEE", align: "left", stroke: "#333333", strokeThickness: 5})
    @text.position.x = 40
    @text.position.y = 10
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)
    @question = question
    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)
    @answers = Game.answers[@question]['answers']

  keydown: (event) ->
    if @active
      if event.keyCode == Game.Key.UP
        @moveUp()
      else if event.keyCode == Game.Key.DOWN
        @moveDown()
      else if event.keyCode == Game.Key.ENTER
        @finalize()

  update: (dt) ->
    @displayAnswers()

  finalize: ->
    @text.setText('')
    @answer = @getAnswers()[ @selection ].value
    @active = false

  moveUp: ->
    @selection-- if @selection > 0
  moveDown: ->
    @selection++ if @selection < @getAnswers().length - 1

  displayAnswers: ->
    text = ''
    index = 0
    if @active == true
      text += @getQuestion() + '\n'
      for answer in @getAnswers()
        if index == @selection
          text += '>'
        else
          text += '  '
        text += answer.displayText + '\n'
        index++
    @text.setText(text)


  getQuestion: ->
    Game.answers[@question]['question']
  getAnswers: ->
    @answers
