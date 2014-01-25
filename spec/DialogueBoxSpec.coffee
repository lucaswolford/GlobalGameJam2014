describe 'DialogueBox', ->
  beforeEach ->
    stageStub =
      addChild: -> null
    @box = new Game.DialogueBox(stageStub)

  it 'not null', ->
    expect(@box).not.toBe( null )

  describe 'update', ->
    it 'sets visiblePosition', ->
      @box.update(1)
      expect(@box.visiblePosition).toBe( @box.textSpeed )

    it 'sets text', ->
      spyOn @box.text, 'setText'
      @box.update(1)
      expect( @box.text.setText ).toHaveBeenCalled()

  it 'displayAll', ->
    spyOn(@box, 'getGameDialogue').andReturn( '123' )
    @box.displayAll()
    expect(@box.visiblePosition).toBe( 3 )

  describe 'isAtEndOfLine', ->
    beforeEach ->
      spyOn(@box, 'getGameDialogue').andReturn( '123' )
    it 'no', ->
      @box.visiblePosition = 1
      expect( @box.isAtEndOfLine() ).toBe( false )
    it 'yes', ->
      @box.visiblePosition = 3
      expect( @box.isAtEndOfLine() ).toBe( true )

  describe 'nextLine', ->
    it 'adds to index', ->
      prevIndex = @box.index
      @box.nextLine()
      expect( @box.index ).toBe( prevIndex + 1 )

    it 'stops at the end', ->
      spyOn( Game, 'dialogue' ).andReturn( ['a', 'b'] )
      @box.index = 1
      @box.nextLine()
      expect( @box.index ).toBe( 1 )

    it 'resets visiblePosition', ->
      @box.visiblePosition = 5
      @box.nextLine()
      expect( @box.visiblePosition ).toBe( 0 )

