class Game.WorldCollisionRects
  # obtained with DevRectDraw
  rects: [{"x1":1,"y1":111,"x2":604,"y2":408},{"x1":343.89999999999986,"y1":3,"x2":453.89999999999986,"y2":109},{"x1":452.59999999999997,"y1":3,"x2":867.5999999999999,"y2":24},{"x1":859.9999999999983,"y1":5,"x2":960.9999999999983,"y2":110},{"x1":669,"y1":111,"x2":1396,"y2":379},{"x1":670,"y1":359,"x2":1399,"y2":415},{"x1":841,"y1":732,"x2":1373,"y2":798},{"x1":1372,"y1":734,"x2":1399,"y2":788},{"x1":580.4999999999994,"y1":723,"x2":849.4999999999994,"y2":789},{"x1":257,"y1":735,"x2":590,"y2":785},{"x1":2,"y1":721,"x2":269,"y2":764}]
  door:
    x1: 428
    x2: 505
    y1: 409
    y2: 473

  isPlayerColliding: (player) ->
    _.any [ # test all four corners of player
      @isPointColliding(player.positionDesired.x - player.size, player.positionDesired.y - player.size)
      @isPointColliding(player.positionDesired.x - player.size, player.positionDesired.y + player.size)
      @isPointColliding(player.positionDesired.x + player.size, player.positionDesired.y + player.size)
      @isPointColliding(player.positionDesired.x + player.size, player.positionDesired.y - player.size)
    ]

  isPointColliding: (x,y) ->
    _.any(@rects, ((rect) ->
      x > rect.x1 && x < rect.x2 && y > rect.y1 && y < rect.y2
    ))

  isOverDoor: (x,y) ->
    x > @door.x1 && x < @door.x2 && y > @door.y1 && y < @door.y2