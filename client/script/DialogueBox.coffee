class Game.DialogueBox
  text: null

  constructor: (stage) ->
    @text = new PIXI.Text("Text", {font: "bold italic 14px Arvo", fill: "#eeffee", align: "left", stroke: "#ddeeff", strokeThickness: 1})
    @text.position.x = 200
    @text.position.y = 5
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)

  update: (dt) ->
    @text.setText(Game.dialogue[0])