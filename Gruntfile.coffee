module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    watch:
      options:
        spawn: false
        interrupt: true
        interval: 10
      files: [
        'Gruntfile.coffee'
        '<%= pkg.directories.src %>/**/**'
        '<%= pkg.directories.test %>/**/**'
      ]
      tasks: ['test', 'build']

    clean: ['<%= pkg.directories.lib %>/*']

    coffeelint:
      options: configFile: 'coffeelint.json'
      files: [
        'Gruntfile.coffee'
        '<%= pkg.directories.src %>/**/*.coffee'
        '<%= pkg.directories.src %>/**/*.litcoffee'
        '<%= pkg.directories.test %>/**/*.coffee'
        '<%= pkg.directories.test %>/**/*.litcoffee'
      ]

    mochaTest:
      options:
        bail: true
        clearRequireCache: true
        reporter: 'progress'
        require: 'coffee-script/register'

      unit:
        src: [
          '<%= pkg.directories.test %>/unit/*.coffee'
          '<%= pkg.directories.test %>/unit/*.litcoffee'
        ]

      functional:
        src: [
          '<%= pkg.directories.test %>/functional/*.coffee'
          '<%= pkg.directories.test %>/functional/*.litcoffee'
        ]

    coffee:
      options: bare: true
      compile:
        files: [
          expand: true
          cwd: '<%= pkg.directories.src %>/'
          src: ['**/*.coffee', '**/*.litcoffee']
          dest: '<%= pkg.directories.lib %>/'
          ext: '.js'
        ]

  # On watch events, if the changed file is a test file then configure
  # mochaTest to only run the tests from that file. Otherwise run all the
  # tests
  # defaultTestSrc = grunt.config 'mochaTest.test.src'
  # grunt.event.on 'watch', (action, filepath) ->
  #   grunt.config 'mochaTest.test.src', defaultTestSrc
  #   grunt.config 'mochaTest.test.src', filepath if filepath.match 'test/'

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'build', ['clean', 'coffee:compile']
  grunt.registerTask 'test', ['coffeelint', 'mochaTest']

