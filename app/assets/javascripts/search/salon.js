$(function() {
  function addContent(content) {
    var html = `
      <div class='searchbox__form__selected__bgc'>
      <span>×
      </div>
      <span>${content}
    `;
    $(".searchbox__form__selected").append(html);
  }

  $(".searchbox__form__select__list__contents__content").click(function(){
    $(".searchbox__form__selected > span").remove();
    addContent(this.textContent);
    contentid = $(this).data("id");
    $(".searchbox__form__select #content_id").val(contentid);
  });
  $(document).on("click", ".searchbox__form__selected__bgc > span", function() {
    $(".searchbox__form__selected").children().remove();
    $(".searchbox__form__select #content_id").val('');
  });
});