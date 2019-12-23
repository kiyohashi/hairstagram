$(function() {
  
  $(".userpagelist:not(.active)").hover(function() {

    $(this).css("background-color", "rgba(128, 128, 128, 0.1)");
  }, function() {

    $(this).css("background-color", "#FFF");
  });
});
$(function() {
  $(".nav li").click(function() {
    $(".nav li").removeClass('active');

    $(this).addClass('active')
  });
});