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

  $(".searchbox__form__check > label").click(function () {
    $(".searchbox__form__length-selected").children().remove();
    $(".searchbox__form__select #length_id").val('');
    $('.searchbox__form__length-selected').css('height','0');
    $('#Women-contents').children().css('display','none');
    $('#Men-contents').children().css('display','none');
    $('#nogender').css('display','block');

    if ($("#gender_ids_1").prop("checked") == true) {
      $('#Women-contents').children().css('display','block');
      $('#nogender').css('display','none');
    } else {
    }
  
    if ($("#gender_ids_2").prop("checked") == true) {
      $('#Men-contents').children().css('display','block');
      $('#nogender').css('display','none');
    } else {
    }

    if ($("#gender_ids_3").prop("checked") == true) {
      $('#Women-contents').children().css('display','block');
      $('#Men-contents').children().css('display','block');
      $('#nogender').css('display','none');
    } else {
    }
  });

  $(document).on("click", ".length-content", function() {
    $(".searchbox__form__length-selected > span").remove();
    contentid = $(this).data("id");
    var box = $('.searchbox__form__length-selected')
    var genre = "length"
    addContent(this.textContent, genre, contentid, box);
    $('.searchbox__form__length-selected').css('height','3rem');
    $(".searchbox__form__select #length_id").val(contentid);
  });
  $(document).on("click", ".searchbox__form__length-selected > .searchbox__form__selected__bgc > span", function() {
    $(".searchbox__form__length-selected").children().remove();
    $(".searchbox__form__select #length_id").val('');
    $('.searchbox__form__length-selected').css('height','0');
  });


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
    $('.modal').css('display','none');
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