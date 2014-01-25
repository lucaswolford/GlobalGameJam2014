// From https://github.com/mandarinx/GameDevTemplateJS

module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-exec');

    grunt.registerMultiTask('spritesheet',
                            'Pack directories as separate atlases',
                            function() {

        grunt.config('exec.', {
            cmd: 'pm run spritesheet',
            stdout: true,
            stderr: true
        });

        grunt.task.run('exec');
    });

};
