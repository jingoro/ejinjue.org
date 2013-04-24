/* easteregg.in - where you go to get your website's easter eggs */
(function(window, undefined){
var konami_keys = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65],
  konami_index = 0,
  handler = function(e) {
    if (e.keyCode === konami_keys[konami_index++]) {
      if (konami_index === konami_keys.length) {
        $(document).unbind("keydown", handler);
        $.getScript("http://cdn.easteregg.in/outcomes/cornify/cornify.js", function() {
          var finishHim = function() {
              cornify_add();
            };
          $(document).keydown(finishHim);
          finishHim();
        });
      }
    } else {
      konami_index = 0;
    }
  };
$(document).bind("keydown", handler);
})(this);
