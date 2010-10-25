jQuery(function($) {

  // Creamos una variable para que el compilador comprima las llamadas a window
  var $window = window;
  var wysiwyg_insert_image_callback_name = "wysiwyg_insert_image_callback"
  var wysiwyg_div_class_name = "wysiwyg_modal_image";
  var wysiwyg_iframe_class_name = "wysiwyg_file_selector";

  if(!$window["editor_insert_images_path"])
    return;

  var editor_insert_images_path = $window["editor_insert_images_path"];

  $window["custom_insert_image_into_wysiwyg"] = function(element) {
    var $body = $(document.body);
    var hider = $("<div>", {"class": wysiwyg_div_class_name}).css("opacity", 0.5).appendTo($body);
    var iframe = $("<iframe>", {src: editor_insert_images_path, "class": wysiwyg_iframe_class_name}).appendTo($body);

    iframe.bind("load", function() { iframe.height($(this.contentDocument).height() + 30); });

    $window[wysiwyg_insert_image_callback_name] = function(image_url) {

      if(image_url) {
        element.focus();
        element.editorDoc.execCommand('insertImage', false, image_url);
      }

      $("div."+wysiwyg_div_class_name).remove();
      $("iframe."+wysiwyg_iframe_class_name).remove();
      $window[wysiwyg_insert_image_callback_name] = null;
    }
  };

});
