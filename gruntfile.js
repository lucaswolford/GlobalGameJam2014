module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        clean: {
            dist: ['dist/']
        },
        copy: {
            dist: {
                files: [
                    {src: ['client/index.html'], dest: 'dist/index.html'},
                    {src: 'client/lib/*', dest: 'dist/lib/', expand: true, flatten: true},
                    {src: 'assets/output/*', dest: 'dist/assets/', expand: true, flatten: true}
                ]
            }
        },
        coffee: {
            compileForWeb: {
                files: {
                    'dist/js/game.js': ['client/script/bootstrap.coffee','client/script/**/*.coffee'],
                    'spec/mainSpec.js': 'spec/mainSpec.coffee'
                }
            },
            compileForTests: {
                files: {
                    'spec/tests.js': ['client/script/bootstrap.coffee','client/script/**/*.coffee','!client/script/main.coffee'],
                    'spec/allSpec.js': 'spec/*Spec.coffee'
                }
            }
        },
        texturepacker: {
            all: {
                targetdir: 'assets/output',
                dirs: [ 'assets/main' ]
            }
        },
        exec: {
            spritesheet: {
                cmd: 'pm run spritesheet'
            }
        },
        jasmine: {
            test: {
                src: ['client/lib/*.js','spec/tests.js'],
                options: {
                    specs: 'spec/*Spec.js',
                    helpers: 'spec/*Helper.js'
                }
            }
        },
        coffeelint: {
            all: {
                files: {
                    src: ['client/script/**/*.coffee','spec/*.coffee']
                },
                options: {
                    'max_line_length': {
                        'level': 'ignore'
                    }
                }
            }
        },
        watch: {
            files: ['client/**/*', 'spec/*.coffee'],
            tasks: ['dist','test'],
            options: {
                livereload: true
            }
        },
        'gh-pages': {
            options: {
                base: 'dist',
                repo: 'https://github.com/Code6226/GameJamPractice.git'
            },
            src: '**'
        }
    });

    // Load the plugins
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-jasmine');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-gh-pages');
    grunt.loadTasks('./tasks');

    // Make production version
    grunt.registerTask('dist', ['clean:dist','copy:dist','coffee:compileForWeb']);
    grunt.registerTask('test', ['coffee:compileForTests','jasmine']);
    grunt.registerTask('lint', ['coffeelint']);
    grunt.registerTask('spritesheet', ['exec:spritesheet']);
    grunt.registerTask('deploy', ['test','lint','dist','gh-pages']);

    // Default task(s).
    grunt.registerTask('default', ['dist','test','lint','watch']);

};
