const gulp = require('gulp');
const pug = require('gulp-pug');

gulp.task('views', () => {
    return gulp.src('views/*.pug')
    .pipe(pug({}))
    .pipe(gulp.dest('compiled'));
});
