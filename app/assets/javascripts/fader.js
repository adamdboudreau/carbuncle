var Fader = function (options) {
  var width = options.width || "1080px",
    height = options.height || "720px",
    fDiv = options.innerDiv || '',
    bDiv = options.outerDiv || '',
    banner = options.banner || '',
    images = options.images || [],
    imageListLength = images.length,
    speed = options.speed || 1000,
    index = 0,
    currentImage = images[0],
    backgroundText = '';

  if (typeof width === "number") {
    width = width.toString() + 'px';
  }
  if (typeof height === "number") {
    height = height.toString() + 'px';
  }

  this.nextIndex = function() {
    if (index < (imageListLength - 1)) {
      index ++;
    } else {
      index = 0;
    }
  };
  // Initialize the width/height of the divs and img
  $(bDiv).css('width', width);
  $(bDiv).css('height', height);
  $(fDiv).css('width', width);
  $(fDiv).css('height', height);
  $(banner).width(width);
  $(banner).height(height);

  this.start = function () {
    this.nextIndex();
    currentImage = images[index];
    $(bDiv).css({
        "background-image" : "url('" + currentImage + "')",
        "background-size" : width + ' ' + height,
        "background-repeat" : 'no-repeat'
      });

    $(fDiv).fadeOut(speed, function () {
      $(banner).prop("src",currentImage);
      $(banner).width(width);
      $(banner).height(height);
      $(fDiv).fadeIn(speed);
    });
  }.bind(this);
};