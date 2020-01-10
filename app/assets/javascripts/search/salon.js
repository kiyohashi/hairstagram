$(function() {
  function addArea(area) {
    var html = `
      <div class='searchbox__salon__area-selected__bgc'>
      <span>×
      </div>
      <span>${area}
    `;
    $(".searchbox__salon__area-selected").append(html);
  }

  $(".searchbox__salon__area-select__list__areas__area").click(function(){
    $(".searchbox__salon__area-selected > span").remove();
    addArea(this.textContent);
    areaid = $(this).data("id");
    $(".searchbox__salon__area-select #area_id").val(areaid);
  });
  $(document).on("click", ".searchbox__salon__area-selected__bgc > span", function() {
    $(".searchbox__salon__area-selected").children().remove();
    $(".searchbox__salon__area-select #area_id").val('');
  });
});