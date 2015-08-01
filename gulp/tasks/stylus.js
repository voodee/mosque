// include the required packages.
var gulp         = require('gulp'),
    browserSync  = require('browser-sync'),
    stylus       = require('gulp-stylus'),
    handleErrors = require('../util/handleErrors'),
    myth         = require('gulp-myth'),
    nib          = require('nib'),
    sourcemaps   = require('gulp-sourcemaps'),
    config       = require('../config').stylus,
    bootstrap    = require('bootstrap-styl');



gulp.task('stylus', function () {
  return gulp.src(config.src)
    .pipe(sourcemaps.init())
    .pipe(stylus({
      use: [nib(),bootstrap()],
      compress: true
    }))
    .on('error', handleErrors)
    .pipe(sourcemaps.write())
    .pipe(myth())
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));
});