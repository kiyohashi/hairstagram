$(function() {
  function addSalon(salon) {
    var html = `
      <div class="post-result-salon">
        <p class="post-result-salon__name" data-salon-id="${salon.id}" data-salon-name="${salon.name}">${salon.name}</p>
      </div>
    `;
    $("#salon-search-result").append(html);
  }

  function addNoSalon() {
    let html = `
      <div class="post-result-nosalon">
        <p class="post-result-salon__name">サロンが見つかりません</p>
      </div>
    `;
    $("#salon-search-result").append(html);
  }

  function addContent(content, id) {
    var html = `
      <div class='searchbox__form__selected__bgc'>
      <span>×
      </div>
      <span id='salon-selected' data-id=${id}>${content}
    `;
    $(".searchbox__form__salon-selected").append(html);
  }

  $(document).on("keyup", "#salon-search", function() {
    var input = $("#salon-search").val();
    if ($("#area-selected")[0] != null) {
      var areaId = $("#area-selected").data("id");
    } else {
      var areaId = ''
    }
    $.ajax({
      type: "GET",
      url: "/salons",
      data: { keyword: input, area_id: areaId },
      dataType: "json"
    })
    .done(function(salons) {
      $("#salon-search-result").empty();
      if (salons.length !== 0) {
        salons.forEach(function(salon) {
          addSalon(salon);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoSalon();
      }
    })
    .fail(function() {
      alert("通信エラーです。スタイルが表示できません。");
    });
  });

  $(document).on("click", ".post-result-salon > p", function() {
    $(".searchbox__form__salon-selected > span").remove();
    $("#salon-search-result").empty();
    contentid = $(this).data("salonId");
    addContent(this.textContent, contentid);
    $("#salon-search").val('');
    $('.searchbox__form__salon-selected').css('height','3rem');
    $(".searchbox__form__search #content_id").val(contentid);
  });


  $(document).on("click", ".searchbox__form__salon-selected > .searchbox__form__selected__bgc > span", function() {
    $(".searchbox__form__salon-selected").children().remove();
    $('.searchbox__form__salon-selected').css('height','0');
    $('.searchbox__form__selected').css('height','0');
    $(".searchbox__form__search #content_id").val('');
  });



  $(document).on("keyup", "#item-search", function() {
    var input = $("#item-search").val();
    $.ajax({
      type: "GET",
      url: "/items",
      data: { keyword: input },
      dataType: "json"
    })
    .done(function(items) {
      $("#item-search-result").empty();
      if (items.length !== 0) {
        items.forEach(function(item) {
          addItem(item);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoItem();
      }
    })
    .fail(function() {
      alert("通信エラーです。アイテムが表示できません。");
    });
  });
});