$(function() {
  function addContent(content, id) {
    var html = `
      <div class='searchbox__form__selected__bgc'>
      <span>×
      </div>
      <span id='area-selected' data-id=${id}>${content}
    `;
    $(".searchbox__form__genre-selected").append(html);
  }

  $(document).on("click", ".genre-content", function() {
    $(".searchbox__form__genre-selected > span").remove();
    contentid = $(this).data("id");
    addContent(this.textContent, contentid);
    $('.searchbox__form__genre-selected').css('height','3rem');
    $(".searchbox__form__select #content_id").val(contentid);
  });
  $(document).on("click", ".searchbox__form__selected__bgc > span", function() {
    $(".searchbox__form__genre-selected").children().remove();
    $(".searchbox__form__select #content_id").val('');
    $('.searchbox__form__genre-selected').css('height','0');
  });
});