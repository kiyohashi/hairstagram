$(function() {
  $(document).ready(function() {
    if (location.pathname.match(/timeline/)) {
      if ( location.pathname.match(/all/)) {
        $("#genderAll").addClass('active');
      } else if (location.pathname.match(/women/)){
        $("#genderWomen").addClass('active');
      } else if (location.pathname.match(/free/)){
        $("#genderFree").addClass('active');
      } else {
        $("#genderMen").addClass('active');
      }
      $(".footer__container__content__timeline > span").addClass('selecting');
    }
  });
});