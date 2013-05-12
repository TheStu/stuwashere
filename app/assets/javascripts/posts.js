function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".field-block").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function(){

  var popped = false;
  var value = 0;

  var barPosition = function(){
    var $bar = jQuery(".social-bar");
    offset = jQuery('#content-section').offset(); // 173
    $bar.css({"left":(offset.left - $bar.outerWidth() - 6),"display":"block"});
  };

  var hiddenBar = function(){
    $('.social-arrow').css("display","block");
    if (popped == false) {
      $(".social-bar").css("display","none");
    }
    else {
      $(".social-bar").css({"left":"-4px","display":"block"});
    }
  };

  if ($(window).width() > 1050) {
    $('.social-arrow').css("display","none");
    barPosition();
  }
  else {
    hiddenBar();
  }

  jQuery(window).resize(function(){
    if ($(window).width() > 1050) {
      barPosition();
      $('.social-arrow').css("display","none");
    }
    else {
      hiddenBar();
    }
  });

  $('.social-arrow').click(function() {
    value += 180;
    if (popped == false) {
      popped = true;
      $(".social-bar").css({"left":"-4px","display":"block"});
      $('.social-arrow-img').rotate({animateTo:value});
    }
    else {
      popped = false;
      $(".social-bar").css({"left":"-4px","display":"none"});
      $('.social-arrow-img').rotate({animateTo:value});
    }
  });
});
