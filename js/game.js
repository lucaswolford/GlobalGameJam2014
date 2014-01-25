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
  Game.City = (function() {
    function City(stage) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("worldbg"));
      this.sprite.anchor.x = 0;
      this.sprite.anchor.y = 0;
      this.sprite.position.x = this.sprite.position.y = 0;
      stage.addChild(this.sprite);
    }

    City.prototype.update = function() {
      return null;
    };

    return City;

  })();

}).call(this);

(function() {
  Game.DialogueBox = (function() {
    DialogueBox.prototype.text = null;

    DialogueBox.prototype.visiblePosition = 0;

    DialogueBox.prototype.index = 0;

    DialogueBox.prototype.textSpeed = 10;

    DialogueBox.prototype.active = true;

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
      } else {
        return this.hide();
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

    DialogueBox.prototype.hide = function() {
      this.text.setText('');
      return this.active = false;
    };

    return DialogueBox;

  })();

}).call(this);

(function() {
  Game.Item = (function() {
    Item.prototype.size = 32;

    function Item(x, y, stage) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("item"));
      this.sprite.anchor.x = 0.5;
      this.sprite.anchor.y = 0.5;
      this.sprite.position.x = x;
      this.sprite.position.y = y;
      stage.addChild(this.sprite);
    }

    Item.prototype.update = function() {
      return null;
    };

    Item.prototype.playerCollision = function() {
      return this.sprite.position.x = -1000;
    };

    return Item;

  })();

}).call(this);

(function() {
  Game.UpdateManager = (function() {
    UpdateManager.prototype.containerWorld = null;

    UpdateManager.prototype.containerUI = null;

    UpdateManager.prototype.dialog = null;

    UpdateManager.prototype.player = null;

    UpdateManager.prototype.city = null;

    UpdateManager.prototype.items = [];

    UpdateManager.prototype.time = null;

    function UpdateManager(containerWorld, containerUI) {
      this.containerWorld = containerWorld;
      this.containerUI = containerUI;
    }

    UpdateManager.prototype.dt = function() {
      var dt, now;
      now = Date.now();
      dt = now - (this.time || now);
      dt *= 0.001;
      this.time = now;
      return dt;
    };

    UpdateManager.prototype.updateAll = function() {
      var dt, object, _i, _len, _ref;
      dt = this.dt();
      if (this.dialog.active) {
        this.dialog.update(dt);
      } else {
        this.city.update(dt);
        this.player.update(dt);
        _ref = this.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          object = _ref[_i];
          object.update(dt);
          if (this.ifPlayerCollision(object)) {
            object.playerCollision();
          }
        }
      }
      this.containerWorld.position.x = Game.SCREEN_SIZE.Xhalf - this.player.sprite.position.x;
      return this.containerWorld.position.y = Game.SCREEN_SIZE.Yhalf - this.player.sprite.position.y;
    };

    UpdateManager.prototype.ifPlayerCollision = function(object) {
      var dist, distX, distY;
      distX = this.player.sprite.position.x - object.sprite.position.x;
      distY = this.player.sprite.position.y - object.sprite.position.y;
      dist = Math.sqrt((distX * distX) + (distY * distY));
      return dist <= (this.player.size + object.size);
    };

    return UpdateManager;

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
    function InputManager() {
      window.addEventListener('keyup', (function(event) {
        return Game.Key.onKeyup(event);
      }), false);
      window.addEventListener('keydown', (function(event) {
        return Game.Key.onKeydown(event);
      }), false);
    }

    return InputManager;

  })();

}).call(this);

(function() {
  Game.Player = (function() {
    Player.prototype.speed = 200;

    Player.prototype.size = 10;

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
  var animate, assetsLoaded, containerUI, containerWorld, input, loader, onAssetsLoaded, renderer, stage, updater;

  stage = new PIXI.Stage(0x000000);

  containerUI = new PIXI.DisplayObjectContainer();

  containerWorld = new PIXI.DisplayObjectContainer();

  stage.addChild(containerWorld);

  stage.addChild(containerUI);

  Game.SCREEN_SIZE = {
    X: 800,
    Y: 600
  };

  Game.SCREEN_SIZE.Xhalf = Game.SCREEN_SIZE.X / 2;

  Game.SCREEN_SIZE.Yhalf = Game.SCREEN_SIZE.Y / 2;

  renderer = PIXI.autoDetectRenderer(Game.SCREEN_SIZE.X, Game.SCREEN_SIZE.Y, null);

  document.body.appendChild(renderer.view);

  input = new Game.InputManager;

  updater = new Game.UpdateManager(containerWorld, containerUI);

  assetsLoaded = false;

  onAssetsLoaded = function() {
    updater.city = new Game.City(containerWorld);
    updater.items.push(new Game.Item(400, 400, containerWorld));
    updater.items.push(new Game.Item(400, 500, containerWorld));
    updater.player = new Game.Player(400, 150, containerWorld);
    updater.dialog = new Game.DialogueBox(containerUI);
    return assetsLoaded = true;
  };

  loader = new PIXI.AssetLoader(['assets/main0.json']);

  loader.onComplete = onAssetsLoaded;

  loader.load();

  animate = function() {
    requestAnimFrame(animate);
    if (assetsLoaded === true) {
      updater.updateAll();
    }
    return renderer.render(stage);
  };

  requestAnimFrame(animate);

}).call(this);
