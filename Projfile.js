// From: http://peepsquest.com/tutorials/creatingSpritesheets.html
exports.project = function(pm) {
    var f = pm.filters(require('pm-spritesheet'));

    return {
        spritesheet: {
            files: 'assets/main/*.png',
            dev: [
                f.spritesheet({
                    filename: 'assets/output/main0.png',
                    root: 'assets/main',
                    jsonStyle:'texturePacker'
                })
            ]
        }
    };

};