describe 'DialogueBox', ->
  beforeEach ->
    stageStub =
      addChild: -> null
    @box = new Game.DialogueBox(stageStub)

  it 'not null', ->
    expect(@box).not.toBe( null )
