$(function() {
  $(".gender-select__list li").click(function() {
    $(".gender-select__list li").removeClass('active');

    $(".ranking__contents > div").removeClass('active');
    $(".timeline__main__posts > div").removeClass('active');
    var id_gender = $(this).attr('id')
    var posts = document.getElementsByClassName(id_gender)[0];
    $(posts).addClass('active');
    $(this).addClass('active');
  });
});