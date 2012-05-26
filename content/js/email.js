var dropTarget = $('#drop-target');

var processText;

dropTarget
  // dragover is necessary
  .bind('dragover', function(event) {
    dropTarget.addClass('drag');
    event.preventDefault();
    return false;
  })
  .bind('dragleave', function(event) {
    dropTarget.removeClass('drag');
    event.preventDefault();
    return false;
  })
  .bind('drop', function(event) {
    console.log('drop');
    event.preventDefault();
    var files = event.originalEvent.dataTransfer.files;
    // pick first
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function(event) {
      processText(event.target.result);
    }
    reader.readAsText(file);
    return false;
  })
;

processText = function(text) {
  // Substitute \r with \n
  text = text.replace(/\r\n/g, "\n");
  $.each(text.split("\n"), function(i, line) {
    line = $.trim(line);
    if (line == '') {
      return;
    }
    console.log(line);
  });
}
