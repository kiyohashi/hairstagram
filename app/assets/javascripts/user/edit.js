$(function() {
  
  function lengthDisplay() {
    $(".user-edit__contents__main__basicForm__length__select__women").css('display','none');
    $(".user-edit__contents__main__basicForm__length__select__men").css('display','none');

    var genderId = $('input[name="user[gender_id]"]:checked').val();

    if (genderId == 1) {
      $(".user-edit__contents__main__basicForm__length__select__women").css('display','block');
      $('#nogender').css('display','none');
    } else if (genderId == 2){ 
      $(".user-edit__contents__main__basicForm__length__select__men").css('display','block');
      $('#nogender').css('display','none');
    } else if (genderId == 3){ 
      $(".user-edit__contents__main__basicForm__length__select__women").css('display','block');
      $(".user-edit__contents__main__basicForm__length__select__men").css('display','block');
      $('#nogender').css('display','none');
    }
  }

  $(document).ready(function(){
    lengthDisplay()
  });

  $(".user-edit__contents__main__basicForm__gender__select > label").click(function(){
    lengthDisplay()
  })


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
    dom.attr('src', '/assets/egg-icon-gray.png');
    $('#user_icon').val(null);
  });
});