gulp           = require 'gulp'
gutil          = require 'gulp-util'
clean          = require 'gulp-clean'
coffeelint     = require 'gulp-coffeelint'
coffee         = require 'gulp-coffee'
react          = require 'gulp-react'
sequence       = require 'run-sequence'
less       = require 'gulp-less'

gulp.task 'default', () ->
  gutil.log 'Available gulp tasks:'
  gutil.log ' *', gutil.colors.magenta('gulp develop'), '- Start development. Watch and build files'
  gutil.log ' *', gutil.colors.magenta('gulp build'), '- Build whole application'
  gutil.log ' *', gutil.colors.magenta('gulp clean'), '- Purge /dist folder'

gulp.task 'develop', () ->
  sequence 'build', 'watch'

gulp.task 'build', ['scripts', 'less']

gulp.task 'watch', () ->
  gulp.watch 'src/**/*.coffee', ['scripts']
  gulp.watch 'less/*.less', ['less']

gulp.task 'scripts', ['clean'], () ->
  gulp.src 'src/**/*.coffee'
    #.pipe coffeelint({ max_line_length: { value: 160 }, no_backticks: { value: 'ignore'} })
    #.pipe coffeelint.reporter()
    .pipe coffee({ bare: true }).on('error', gutil.log)
    .pipe react()
    .pipe gulp.dest('dist')

gulp.task 'clean', () ->
  gulp.src 'dist', { read: false }
    .pipe clean()

gulp.task 'less', () ->
  gulp.src 'less/*.less'
    .pipe less({ compress: true })
    .pipe gulp.dest('css')