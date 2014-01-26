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
    City.prototype.width = 0;

    City.prototype.height = 0;

    function City(stage) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("worldbg"));
      this.width = this.sprite.texture.width;
      this.height = this.sprite.texture.height;
      stage.addChild(this.sprite);
    }

    City.prototype.update = function() {
      return null;
    };

    return City;

  })();

}).call(this);

(function() {
  Game.DevRectDraw = (function() {
    function DevRectDraw(stage) {
      var _this = this;
      this.graphics = new PIXI.Graphics();
      stage.addChild(this.graphics);
      stage.interactive = true;
      this.graphics.beginFill(0xFFFF00);
      this.graphics.lineStyle(5, 0xFF0000);
      this.rects = [];
      stage.mousedown = stage.touchstart = function(data) {
        _this.dragging = true;
        return _this.draggingData = data.global.clone();
      };
      stage.mouseup = stage.mouseupoutside = function(data) {
        _this.dragging = false;
        _this.graphics.drawRect(_this.draggingData.x - stage.position.x, _this.draggingData.y - stage.position.y, data.global.x - _this.draggingData.x, data.global.y - _this.draggingData.y);
        _this.rects.push({
          x1: _this.draggingData.x - stage.position.x,
          y1: _this.draggingData.y - stage.position.y,
          x2: data.global.x - stage.position.x,
          y2: data.global.y - stage.position.y
        });
        return console.log(_this.rects);
      };
      stage.mousemove = stage.touchmove = function(data) {
        if (_this.dragging) {
          return null;
        }
      };
    }

    return DevRectDraw;

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
      this.text = new PIXI.Text("", {
        font: "bold italic 36px Arvo",
        fill: "#11FF11",
        align: "left",
        stroke: "#22FF00",
        strokeThickness: 1
      });
      this.text.position.x = 30;
      this.text.position.y = 10;
      this.text.anchor.x = this.text.anchor.y = 0;
      stage.addChild(this.text);
      window.addEventListener('keydown', (function(event) {
        return _this.keydown(event);
      }), false);
      this.playScript('detective', 'initial');
    }

    DialogueBox.prototype.update = function(dt) {
      this.text.setText(this.getGameDialogue().slice(0, +this.visiblePosition + 1 || 9e9));
      return this.visiblePosition += this.textSpeed * dt;
    };

    DialogueBox.prototype.keydown = function(event) {
      if (event.keyCode === 32) {
        if (this.isAtEndOfLine()) {
          return this.nextLine();
        } else {
          return this.displayAll();
        }
      }
    };

    DialogueBox.prototype.displayAll = function() {
      return this.visiblePosition = this.getGameDialogue().length;
    };

    DialogueBox.prototype.nextLine = function() {
      if (this.index < Game.dialogue[this.npc][this.mood].length - 1) {
        this.index++;
        return this.visiblePosition = 0;
      } else {
        return this.hide();
      }
    };

    DialogueBox.prototype.isAtEndOfLine = function() {
      return this.visiblePosition >= this.getGameDialogue().length;
    };

    DialogueBox.prototype.getGameDialogue = function() {
      return Game.dialogue[this.npc][this.mood][this.index];
    };

    DialogueBox.prototype.hide = function() {
      this.text.setText('');
      return this.active = false;
    };

    DialogueBox.prototype.playScript = function(npc, mood) {
      this.active = true;
      this.npc = npc;
      this.mood = mood;
      this.index = 0;
      return this.visiblePosition = 0;
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

    Item.prototype.playerActivated = function() {
      return this.sprite.position.x = -1000;
    };

    return Item;

  })();

}).call(this);

(function() {
  Game.Npc = (function() {
    Npc.prototype.size = 20;

    Npc.prototype.name = null;

    Npc.prototype.mood = null;

    Npc.prototype.active = false;

    function Npc(x, y, stage, name, mood) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"));
      this.sprite.anchor.x = 0.5;
      this.sprite.anchor.y = 0.5;
      this.sprite.position.x = x;
      this.sprite.position.y = y;
      stage.addChild(this.sprite);
      this.name = name;
      this.mood = mood;
    }

    Npc.prototype.update = function() {
      return null;
    };

    Npc.prototype.playerActivated = function(dialog) {
      this.toggleActive();
      return dialog.playScript(this.name, this.mood);
    };

    Npc.prototype.toggleActive = function() {
      return this.active = !this.active;
    };

    return Npc;

  })();

}).call(this);

(function() {
  Game.Question = (function() {
    Question.prototype.selection = 0;

    Question.prototype.question = null;

    Question.prototype.active = true;

    Question.prototype.answer = null;

    function Question(stage, question) {
      var _this = this;
      this.text = new PIXI.Text("", {
        font: "bold italic 36px Arvo",
        fill: "#11FF11",
        align: "left",
        stroke: "#22FF00",
        strokeThickness: 1
      });
      this.text.position.x = 40;
      this.text.position.y = 10;
      this.text.anchor.x = this.text.anchor.y = 0;
      stage.addChild(this.text);
      this.question = question;
      window.addEventListener('keydown', (function(event) {
        return _this.keydown(event);
      }), false);
    }

    Question.prototype.keydown = function(event) {
      if (event.keyCode === Game.Key.UP) {
        return this.moveUp();
      } else if (event.keyCode === Game.Key.DOWN) {
        return this.moveDown();
      } else if (event.keyCode === Game.Key.ENTER) {
        return this.finalize();
      }
    };

    Question.prototype.update = function(dt) {
      return this.displayAnswers();
    };

    Question.prototype.finalize = function() {
      this.text.setText("a");
      this.answer = this.selection;
      return this.active = false;
    };

    Question.prototype.moveUp = function() {
      if (this.selection > 0) {
        return this.selection--;
      }
    };

    Question.prototype.moveDown = function() {
      if (this.selection < this.getAnswers().length - 1) {
        return this.selection++;
      }
    };

    Question.prototype.displayAnswers = function() {
      var answer, index, text, _i, _len, _ref;
      text = '';
      index = 0;
      if (this.active === true) {
        _ref = this.getAnswers();
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          answer = _ref[_i];
          if (index === this.selection) {
            text += '*';
          } else {
            text += ' ';
          }
          text += answer + '\n';
          index++;
        }
      }
      return this.text.setText(text);
    };

    Question.prototype.getAnswers = function() {
      return Game.answers[this.question];
    };

    return Question;

  })();

}).call(this);

(function() {
  Game.UpdateManager = (function() {
    UpdateManager.prototype.containerWorld = null;

    UpdateManager.prototype.containerUI = null;

    UpdateManager.prototype.containerTitle = null;

    UpdateManager.prototype.containerInterro = null;

    UpdateManager.prototype.containerShowdown = null;

    UpdateManager.prototype.containerEnd = null;

    UpdateManager.prototype.dialog = null;

    UpdateManager.prototype.player = null;

    UpdateManager.prototype.city = null;

    UpdateManager.prototype.items = [];

    UpdateManager.prototype.npcs = [];

    UpdateManager.prototype.time = null;

    UpdateManager.prototype.worldCollisionRects = null;

    UpdateManager.prototype.moodQuestion = null;

    UpdateManager.prototype.actionQuestion = null;

    UpdateManager.prototype.state = null;

    UpdateManager.prototype.TITLE = 1;

    UpdateManager.prototype.INTERROGATION = 2;

    UpdateManager.prototype.TOPDOWN = 3;

    UpdateManager.prototype.SHOWDOWN = 4;

    UpdateManager.prototype.WRAPUP = 5;

    UpdateManager.prototype.END = 6;

    function UpdateManager(stage, containerWorld, containerUI, containerTitle, containerInterro, containerShowdown, containerEnd) {
      this.worldCollisionRects = new Game.WorldCollisionRects();
      this.stage = stage;
      this.containerWorld = containerWorld;
      this.containerUI = containerUI;
      this.containerTitle = containerTitle;
      this.containerInterro = containerInterro;
      this.containerShowdown = containerShowdown;
      this.containerEnd = containerEnd;
      this.state = this.TITLE;
      this.switchState();
    }

    UpdateManager.prototype.dt = function() {
      var dt, now;
      now = Date.now();
      dt = now - (this.time || now);
      dt *= 0.001;
      this.time = now;
      return dt;
    };

    UpdateManager.prototype.switchState = function() {
      switch (this.state) {
        case this.TITLE:
          return this.titleAddAssets();
        case this.INTERROGATION:
          this.titleRemoveAssets();
          return this.interrogationAddAssets();
        case this.TOPDOWN:
          this.interrogationRemoveAssets();
          return this.topDownAddAssets();
        case this.SHOWDOWN:
          this.topDownRemoveAssets();
          return this.showdowndAddAssetst();
        case this.WRAPUP:
          this.showdowndRemoveAssetst();
          return this.wrapUpAddAssets();
        case this.END:
          this.wrapUpRemoveAssets();
          return this.endAddAssets();
      }
    };

    UpdateManager.prototype.updateGame = function() {
      var dt;
      dt = this.dt();
      switch (this.state) {
        case this.TITLE:
          return this.updateTitle(dt);
        case this.INTERROGATION:
          return this.updateInterrogation(dt);
        case this.TOPDOWN:
          return this.updateTopDown(dt);
        case this.SHOWDOWN:
          return this.updateShowdown(dt);
        case this.WRAPUP:
          return this.updateWrapUp(dt);
        case this.END:
          return this.updateEnd(dt);
      }
    };

    UpdateManager.prototype.ifPlayerCollision = function(object) {
      var dist, distX, distY;
      distX = this.player.sprite.position.x - object.sprite.position.x;
      distY = this.player.sprite.position.y - object.sprite.position.y;
      dist = Math.sqrt((distX * distX) + (distY * distY));
      return dist <= (this.player.size + object.size);
    };

    UpdateManager.prototype.nextState = function() {
      this.state++;
      return this.switchState();
    };

    UpdateManager.prototype.updateTitle = function(dt) {
      if (Game.Key.isDown(Game.Key.SPACE)) {
        return this.nextState();
      }
    };

    UpdateManager.prototype.updateInterrogation = function(dt) {
      if ((Game.Key.isDown(Game.Key.ENTER)) && this.dialog.active === false && this.moodQuestion.active === false) {
        this.nextState();
      }
      if (this.dialog.active) {
        return this.dialog.update(dt);
      } else {
        return this.moodQuestion.update(dt);
      }
    };

    UpdateManager.prototype.updateTopDown = function(dt) {
      var item, npc, playerIsColliding, _i, _j, _len, _len1, _ref, _ref1;
      if (Game.Key.isDown(Game.Key.CTRL)) {
        this.nextState();
      }
      if (this.dialog.active) {
        this.dialog.update(dt);
      } else {
        this.city.update(dt);
        this.player.update(dt);
        playerIsColliding = false;
        _ref = this.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          item.update(dt);
          if (this.ifPlayerCollision(item) && (Game.Key.isDown(Game.Key.SPACE))) {
            item.playerActivated();
          }
        }
        _ref1 = this.npcs;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          npc = _ref1[_j];
          npc.update(dt);
          if (this.ifPlayerCollision(npc) && (Game.Key.isDown(Game.Key.SPACE)) && npc.active === false) {
            npc.playerActivated(this.dialog);
          }
        }
        if (this.worldCollisionRects.isPlayerColliding(this.player)) {
          playerIsColliding = true;
        }
        if (this.player.positionDesired.x < this.player.size || this.player.positionDesired.x > this.city.width - this.player.size) {
          playerIsColliding = true;
        }
        this.player.updateCouldMove(!playerIsColliding);
      }
      this.containerWorld.position.x = Game.SCREEN_SIZE.Xhalf - Math.min(Math.max(this.player.sprite.position.x, Game.SCREEN_SIZE.Xhalf), this.city.width - Game.SCREEN_SIZE.Xhalf);
      return this.containerWorld.position.y = Game.SCREEN_SIZE.Yhalf - Math.min(Math.max(this.player.sprite.position.y, Game.SCREEN_SIZE.Yhalf), this.city.height - Game.SCREEN_SIZE.Yhalf);
    };

    UpdateManager.prototype.updateShowdown = function(dt) {
      this.dialog.update(dt);
      if ((Game.Key.isDown(Game.Key.SPACE)) && this.dialog.active === false) {
        return this.nextState();
      }
    };

    UpdateManager.prototype.updateWrapUp = function(dt) {
      this.dialog.update(dt);
      if ((Game.Key.isDown(Game.Key.SPACE)) && this.dialog.active === false) {
        return this.nextState();
      }
    };

    UpdateManager.prototype.updateEnd = function(dt) {
      if (Game.Key.isDown(Game.Key.SPACE)) {
        return this.nextState();
      }
    };

    UpdateManager.prototype.titleAddAssets = function() {
      return this.stage.addChild(this.containerTitle);
    };

    UpdateManager.prototype.titleRemoveAssets = function() {
      return this.stage.removeChild(this.containerTitle);
    };

    UpdateManager.prototype.interrogationAddAssets = function() {
      this.stage.addChild(this.containerInterro);
      this.stage.addChild(this.containerUI);
      return this.dialog.playScript('detective', 'initial');
    };

    UpdateManager.prototype.interrogationRemoveAssets = function() {
      this.stage.removeChild(this.containerInterro);
      return this.stage.removeChild(this.containerUI);
    };

    UpdateManager.prototype.topDownAddAssets = function() {
      this.stage.addChild(this.containerWorld);
      return this.stage.addChild(this.containerUI);
    };

    UpdateManager.prototype.topDownRemoveAssets = function() {
      this.stage.removeChild(this.containerWorld);
      return this.stage.removeChild(this.containerUI);
    };

    UpdateManager.prototype.showdowndAddAssetst = function() {
      this.stage.addChild(this.containerShowdown);
      this.stage.addChild(this.containerUI);
      return this.dialog.playScript('showdown', 'ending1');
    };

    UpdateManager.prototype.showdowndRemoveAssetst = function() {
      this.stage.removeChild(this.containerShowdown);
      return this.stage.removeChild(this.containerUI);
    };

    UpdateManager.prototype.wrapUpAddAssets = function() {
      this.stage.addChild(this.containerInterro);
      this.stage.addChild(this.containerUI);
      return this.dialog.playScript('detective', 'final1');
    };

    UpdateManager.prototype.wrapUpRemoveAssets = function() {
      this.stage.removeChild(this.containerInterro);
      return this.stage.removeChild(this.containerUI);
    };

    UpdateManager.prototype.endAddAssets = function() {
      return this.stage.addChild(this.containerEnd);
    };

    UpdateManager.prototype.endRemoveAssets = function() {
      return this.stage.removeChild(this.containerEnd);
    };

    return UpdateManager;

  })();

}).call(this);

(function() {
  Game.WorldCollisionRects = (function() {
    function WorldCollisionRects() {}

    WorldCollisionRects.prototype.rects = [
      {
        "x1": 1,
        "y1": 111,
        "x2": 604,
        "y2": 408
      }, {
        "x1": 343.89999999999986,
        "y1": 3,
        "x2": 453.89999999999986,
        "y2": 109
      }, {
        "x1": 452.59999999999997,
        "y1": 3,
        "x2": 867.5999999999999,
        "y2": 24
      }, {
        "x1": 859.9999999999983,
        "y1": 5,
        "x2": 960.9999999999983,
        "y2": 110
      }, {
        "x1": 669,
        "y1": 111,
        "x2": 1396,
        "y2": 379
      }, {
        "x1": 670,
        "y1": 359,
        "x2": 1399,
        "y2": 415
      }, {
        "x1": 841,
        "y1": 732,
        "x2": 1373,
        "y2": 798
      }, {
        "x1": 1372,
        "y1": 734,
        "x2": 1399,
        "y2": 788
      }, {
        "x1": 580.4999999999994,
        "y1": 723,
        "x2": 849.4999999999994,
        "y2": 789
      }, {
        "x1": 257,
        "y1": 735,
        "x2": 590,
        "y2": 785
      }, {
        "x1": 2,
        "y1": 721,
        "x2": 269,
        "y2": 764
      }
    ];

    WorldCollisionRects.prototype.isPlayerColliding = function(player) {
      return _.any([this.isPointColliding(player.positionDesired.x - player.size, player.positionDesired.y - player.size), this.isPointColliding(player.positionDesired.x - player.size, player.positionDesired.y + player.size), this.isPointColliding(player.positionDesired.x + player.size, player.positionDesired.y + player.size), this.isPointColliding(player.positionDesired.x + player.size, player.positionDesired.y - player.size)]);
    };

    WorldCollisionRects.prototype.isPointColliding = function(x, y) {
      return _.any(this.rects, (function(rect) {
        return x > rect.x1 && x < rect.x2 && y > rect.y1 && y < rect.y2;
      }));
    };

    return WorldCollisionRects;

  })();

}).call(this);

(function() {
  Game.dialogue = {
    detective: {
      initial: ["Wow! Much dialogue. Such text.", "init dialogue line 2"],
      final1: ["final dialogue 1 line 1", "final dialogue 1 line 2"],
      final2: ["final dialogue 2 line 1", "final dialogue 2 line 2"]
    },
    showdown: {
      ending1: ["ending 1 line 1", "ending 1 line 2", "ending 1 line 3"],
      ending2: ["ending 2 line 1", "ending 2 line 2", "ending 2 line 3"]
    },
    hobo: {
      relieved: ["hobo relieved", "second line"],
      angry: ["hobo angry", "second line"],
      sad: ["hobo sad", "second line"],
      responsible: ["hobo responsible", "second line"]
    },
    victim: {
      relieved: ["victim relieved", "second line"],
      angry: ["victim angry", "second line"],
      sad: ["victim sad", "second line"],
      responsible: ["victim responsible", "second line"]
    },
    bystander: {
      relieved: ["bystander relieved", "second line"],
      angry: ["bystander angry", "second line"],
      sad: ["bystander sad", "second line"],
      responsible: ["bystander responsible", "second line"]
    }
  };

  Game.answers = {
    mood: ["happy", "sad", "angry"],
    action: ["stab a bitch", "give $$$", "can't we all just get along?"]
  };

}).call(this);

(function() {
  Game.Key = {
    _pressed: {},
    SPACE: 32,
    ENTER: 13,
    CTRL: 17,
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
    Player.prototype.speed = 300;

    Player.prototype.size = 10;

    Player.prototype.positionDesired = null;

    function Player(x, y, stage) {
      this.sprite = new PIXI.Sprite(Game.getTextureFromFrame("bunny"));
      this.sprite.anchor.x = 0.5;
      this.sprite.anchor.y = 0.5;
      this.sprite.position.x = x;
      this.sprite.position.y = y;
      stage.addChild(this.sprite);
      this.positionDesired = this.sprite.position.clone();
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
      return this.positionDesired.y -= this.speed * dt;
    };

    Player.prototype.moveDown = function(dt) {
      return this.positionDesired.y += this.speed * dt;
    };

    Player.prototype.moveRight = function(dt) {
      return this.positionDesired.x += this.speed * dt;
    };

    Player.prototype.moveLeft = function(dt) {
      return this.positionDesired.x -= this.speed * dt;
    };

    Player.prototype.updateCouldMove = function(couldMove) {
      if (couldMove) {
        this.sprite.position.x = this.positionDesired.x;
        return this.sprite.position.y = this.positionDesired.y;
      } else {
        this.positionDesired.x = this.sprite.position.x;
        return this.positionDesired.y = this.sprite.position.y;
      }
    };

    return Player;

  })();

}).call(this);

(function() {
  var animate, assetsLoaded, containerEnd, containerInterro, containerShowdown, containerTitle, containerUI, containerWorld, input, loader, onAssetsLoaded, renderer, stage, updater;

  stage = new PIXI.Stage(0x000000);

  containerUI = new PIXI.DisplayObjectContainer();

  containerWorld = new PIXI.DisplayObjectContainer();

  containerTitle = new PIXI.DisplayObjectContainer();

  containerInterro = new PIXI.DisplayObjectContainer();

  containerShowdown = new PIXI.DisplayObjectContainer();

  containerEnd = new PIXI.DisplayObjectContainer();

  Game.SCREEN_SIZE = {
    X: 800,
    Y: 600
  };

  Game.SCREEN_SIZE.Xhalf = Game.SCREEN_SIZE.X / 2;

  Game.SCREEN_SIZE.Yhalf = Game.SCREEN_SIZE.Y / 2;

  renderer = PIXI.autoDetectRenderer(Game.SCREEN_SIZE.X, Game.SCREEN_SIZE.Y, null);

  document.body.appendChild(renderer.view);

  input = new Game.InputManager;

  updater = new Game.UpdateManager(stage, containerWorld, containerUI, containerTitle, containerInterro, containerShowdown, containerEnd);

  assetsLoaded = false;

  onAssetsLoaded = function() {
    var endBg, interroBg, showdownBg, title, wrapupBg;
    title = new PIXI.Sprite(Game.getTextureFromFrame("titleScreen"));
    containerTitle.addChild(title);
    interroBg = new PIXI.Sprite(Game.getTextureFromFrame("interrogation"));
    containerInterro.addChild(interroBg);
    updater.moodQuestion = new Game.Question(containerUI, 'mood');
    updater.city = new Game.City(containerWorld);
    updater.items.push(new Game.Item(270, 460, containerWorld));
    updater.items.push(new Game.Item(1260, 470, containerWorld));
    updater.player = new Game.Player(463, 460, containerWorld);
    updater.dialog = new Game.DialogueBox(containerUI);
    updater.npcs.push(new Game.Npc(960, 470, containerWorld, 'hobo', 'sad'));
    updater.npcs.push(new Game.Npc(1180, 680, containerWorld, 'victim', 'angry'));
    showdownBg = new PIXI.Sprite(Game.getTextureFromFrame("showdown"));
    containerShowdown.addChild(showdownBg);
    wrapupBg = new PIXI.Sprite(Game.getTextureFromFrame("interrogation"));
    containerInterro.addChild(wrapupBg);
    endBg = new PIXI.Sprite(Game.getTextureFromFrame("end"));
    containerEnd.addChild(endBg);
    new Game.DevRectDraw(containerWorld);
    return assetsLoaded = true;
  };

  loader = new PIXI.AssetLoader(['assets/main0.json']);

  loader.onComplete = onAssetsLoaded;

  loader.load();

  animate = function() {
    requestAnimFrame(animate);
    if (assetsLoaded === true) {
      updater.updateGame();
    }
    return renderer.render(stage);
  };

  requestAnimFrame(animate);

}).call(this);
