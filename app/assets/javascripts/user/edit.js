$(function() {
  function iconreadURL1(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        var imgprev = $('.user-edit__contents__main__icon__box').children('img');
        imgprev.attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#user_icon").change(function(){
    iconreadURL1(this);
  });
  $(document).on("click", "#removeIcon", function() {
    var dom = $('.user-edit__contents__main__icon__box').children('img');
    dom.attr('src', '');
    $('#user_icon').val('');
  });
});