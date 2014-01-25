(function() {
  window.Game = {};

  Game.getTextureFromFrame = function(frameId, unsafe) {
    var name;
    name = frameId + '.png';
    if (unsafe != null) {
      return PIXI.TextureCache[name] || null;
    } else {
      return PIXI.TextureCache[name] || PIXI.Texture.fromImage(name);
    }
  };

  Game.getTexturesFromFrameBase = function(frameBase) {
    var index, result, textures;
    textures = [];
    result = null;
    index = 0;
    while (true) {
      index++;
      result = Game.getTextureFromFrame(frameBase + index, true);
      if (result != null) {
        textures.push(result);
      } else {
        break;
      }
    }
    return textures;
  };

}).call(this);

(function() {
  Game.DialogueBox = (function() {
    DialogueBox.prototype.text = null;

    DialogueBox.prototype.visiblePosition = 0;

    DialogueBox.prototype.index = 0;

    DialogueBox.prototype.textSpeed = 10;

    function DialogueBox(stage) {
      var _this = this;
      this.text = new PIXI.Text("Text", {
        font: "bold italic 14px Arvo",
        fill: "#eeffee",
        align: "left",
        stroke: "#ddeeff",
        strokeThickness: 1
      });
      this.text.position.x = 200;
      this.text.position.y = 5;
      this.text.anchor.x = this.text.anchor.y = 0;
      stage.addChild(this.text);
      window.addEventListener('keydown', (function(event) {
        return _this.keydown(event);
      }), false);
    }

    DialogueBox.prototype.keydown = function(event) {
      if (event.keyCode === 32) {
        if (!this.isAtEndOfLine()) {
          return this.displayAll();
        } else {
          return this.nextLine();
        }
      }
    };

    DialogueBox.prototype.displayAll = function() {
      return this.visiblePosition = this.getGameDialogue().length;
    };

    DialogueBox.prototype.nextLine = function() {
      if (this.index < Game.dialogue.length - 1) {
        this.index++;
        return this.visiblePosition = 0;
      }
    };

    DialogueBox.prototype.isAtEndOfLine = function() {
      return this.visiblePosition >= this.getGameDialogue().length;
    };

    DialogueBox.prototype.update = function(dt) {
      this.text.setText(this.getGameDialogue().slice(0, +this.visiblePosition + 1 || 9e9));
      return this.visiblePosition += this.textSpeed * dt;
    };

    DialogueBox.prototype.getGameDialogue = function() {
      return Game.dialogue[this.index];
    };

    return DialogueBox;

  })();

}).call(this);

(function() {
  Game.dialogue = ["Hello! This is dog. What does the fox say?", "What you say? What you say?", "We get signal! We get signal!"];

}).call(this);

(function() {
  Game.Key = {
    _pressed: {},
    SPACE: 32,
    LEFT: 37,
    UP: 38,
    RIGHT: 39,
    DOWN: 40,
    isDown: function(keyCode) {
      return this._pressed[keyCode];
    },
    onKeydown: function(event) {
      return this._pressed[event.keyCode] = true;
    },
    onKeyup: function(event) {
      return delete this._pressed[event.keyCode];
    }
  };

  Game.InputManager = (function() {
    function InputManager() {}

    InputManager.prototype.init = function(window) {
      window.addEventListener('keyup', (function(event) {
        return Game.Key.onKeyup(event);
      }), false);
      return window.addEventListener('keydown', (function(event) {
        return Game.Key.onKeydown(event);
      }), false);
    };

    return InputManager;

  })();

}).call(this);

(function() {
  Game.Player = (function() {
    Player.prototype.speed = 10;

    function Player(x, y, stage) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"));
      this.sprite.anchor.x = 0.5;
      this.sprite.anchor.y = 0.5;
      this.sprite.position.x = x;
      this.sprite.position.y = y;
      stage.addChild(this.sprite);
    }

    Player.prototype.update = function(dt) {
      if (Game.Key.isDown(Game.Key.UP)) {
        this.moveUp(dt);
      }
      if (Game.Key.isDown(Game.Key.LEFT)) {
        this.moveLeft(dt);
      }
      if (Game.Key.isDown(Game.Key.DOWN)) {
        this.moveDown(dt);
      }
      if (Game.Key.isDown(Game.Key.RIGHT)) {
        return this.moveRight(dt);
      }
    };

    Player.prototype.moveUp = function(dt) {
      return this.sprite.position.y -= this.speed * dt;
    };

    Player.prototype.moveDown = function(dt) {
      return this.sprite.position.y += this.speed * dt;
    };

    Player.prototype.moveRight = function(dt) {
      return this.sprite.position.x += this.speed * dt;
    };

    Player.prototype.moveLeft = function(dt) {
      return this.sprite.position.x -= this.speed * dt;
    };

    return Player;

  })();

}).call(this);

(function() {
  var SCREEN_SIZE, animate, dialogueBox, input, loader, onAssetsLoaded, player, renderer, stage, time;

  stage = new PIXI.Stage(0x000000);

  SCREEN_SIZE = {
    X: 800,
    Y: 600
  };

  renderer = PIXI.autoDetectRenderer(SCREEN_SIZE.X, SCREEN_SIZE.Y, null);

  document.body.appendChild(renderer.view);

  input = new Game.InputManager(window);

  dialogueBox = new Game.DialogueBox(stage);

  player = null;

  onAssetsLoaded = function() {
    return player = new Game.Player(200, 150, stage);
  };

  loader = new PIXI.AssetLoader(['assets/main0.json']);

  loader.onComplete = onAssetsLoaded;

  loader.load();

  time = null;

  animate = function() {
    var dt, now;
    requestAnimFrame(animate);
    now = Date.now();
    dt = now - (time || now);
    dt *= 0.001;
    time = now;
    dialogueBox.update(dt);
    if (player != null) {
      player.update(dt);
    }
    return renderer.render(stage);
  };

  requestAnimFrame(animate);

}).call(this);
