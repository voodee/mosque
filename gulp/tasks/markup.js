var gulp = require('gulp');
var config = require('../config').markup;
var browserSync  = require('browser-sync');
var haml = require('gulp-haml-coffee');

gulp.task('markup', function() {
  gulp.src([
    config.jsSrc + '/vendor/modernizr-2.8.3.min.js',
    config.jsSrc + '/lib/jquery.mb.YTPlayer.js'
  ], {
    dot: true
  }).pipe(gulp.dest(config.jsDest));

  gulp.src([
    config.srcOther + '/*.{php,png,xml,txt}',
    config.srcOther + '/.htaccess'
  ], {
    dot: true
  }).pipe(gulp.dest(config.dest));


  return gulp.src(config.src)
    .pipe( haml() )
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));
});