
gulp =   require 'gulp'
sass =   require 'gulp-sass'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'



gulp.task 'views', ->
  gulp.src(['./src/app/views/docs/index.html'])
    .pipe(gulp.dest('./dist/docs/'))

gulp.task 'styles', ->
  gulp.src(['./src/app/styles/application.sass'])
    .pipe(sass())
    .pipe(gulp.dest('./dist/docs/styles/'))

gulp.task 'scripts-vendor', ->
  gulp.src([
    './src/vendor/scripts/jquery/**/*.js',
    './src/vendor/scripts/angular/**/*.js'
  ])
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest('./dist/docs/scripts/'))

gulp.task 'scripts-app', ->
  gulp.src(['./src/app/scripts/**/*.coffee'])
    .pipe(concat('application.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest('./dist/docs/scripts/'))



gulp.task 'build', [
  'views'
  'styles'
  'scripts-vendor'
  'scripts-app'
]

gulp.task 'watch', ->
  gulp.watch(['./src/app/styles/**/*.sass'], ['styles'])
  gulp.watch(['./src/app/views/docs/index.html'], ['views'])
  gulp.watch(['./src/vendor/scripts/**/*.js'], ['scripts-vendor'])
  gulp.watch(['./src/app/scripts/**/*.coffee'], ['scripts-app'])



gulp.task 'default', ['build', 'watch']
