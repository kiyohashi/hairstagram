$(function() {
  function addContents(content, genre, box) {
    var html = `
      <div class="post-result-${genre}">
        <p class="post-result-${genre}__name" data-${genre}-id="${content.id}" data-${genre}-name="${content.name}">${content.name}</p>
      </div>
    `;
    box.append(html);
  }

  function addNoContents(genre, box) {
    let html = `
      <div class="post-result-no${genre}">
        <p class="post-result-${genre}__name">結果が見つかりません</p>
      </div>
    `;
    box.append(html);
  }

  function addContent(content, genre, id, box) {
    var html = `
      <div class='searchbox__form__selected__bgc'>
      <span>×
      </div>
      <span id='${genre}-selected' data-id=${id}>${content}
    `;
    box.append(html);
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
    .done(function(contents) {
      var genre = "salon"
      var box = $("#salon-search-result")
      box.empty();
      if (contents.length !== 0) {
        contents.forEach(function(content) {
          addContents(content, genre, box);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoContents(genre, box);
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
    var box = $('.searchbox__form__salon-selected')
    var genre = "salon"
    addContent(this.textContent, genre, contentid, box);
    $("#salon-search").val('');
    box.css('height','3rem');
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
    .done(function(contents) {
      var genre = "item"
      var box = $("#item-search-result")
      box.empty();
      if (contents.length !== 0) {
        contents.forEach(function(content) {
          addContents(content, genre, box);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoContents(genre, box);
      }
    })
    .fail(function() {
      alert("通信エラーです。アイテムが表示できません。");
    });
  });

  $(document).on("click", ".post-result-item > p", function() {
    $(".searchbox__form__item-selected > span").remove();
    $("#item-search-result").empty();
    contentid = $(this).data("itemId");
    var box = $('.searchbox__form__item-selected')
    var genre = "item"
    addContent(this.textContent, genre, contentid, box);
    $("#item-search").val('');
    box.css('height','3rem');
    $(".searchbox__form__search #item_id").val(contentid);
  });


  $(document).on("click", ".searchbox__form__item-selected > .searchbox__form__selected__bgc > span", function() {
    $(".searchbox__form__item-selected").children().remove();
    $('.searchbox__form__item-selected').css('height','0');
    $('.searchbox__form__selected').css('height','0');
    $(".searchbox__form__search #item_id").val('');
  });
});