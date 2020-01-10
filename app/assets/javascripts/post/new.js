$(function() {
  function addBrand(brand) {
    var html = `
      <div class="post-item-brand">
        <p class="post-item-brand__name" data-brand-id="${brand.id}" data-brand-name="${brand.name}">${brand.name}</p>
      </div>
    `;
    $("#brand-search-result").append(html);
  }

  function addNoBrand() {
    let html = `
      <div class="post-item-nobrand">
        <p class="post-item-brand__name">ブランドが見つかりません</p>
      </div>
    `;
    $("#brand-search-result").append(html);
  }

  function addItem(item) {
    let html = `<option value="${item.id}">${item.name}</option>`
    $(".post-new__form__item-brand__item__select").append(html);
  }

  function addPostItem(item) {
    let html = `
                <div class = 'add-item' id = "${item.id}">
                  <div class = 'add-item__image'>
                    <img src = ${item.image}>
                  </div>
                  <div class = 'add-item__name'>
                    ${item.name}
                  </div>
                </div>
                `
    $(".post-new__form__item-brand__selected").append(html);
  }

  function addPodtItemForm(item) {
    let html = `<input value="${item.id}" name="post[item_ids][]" type="hidden" id="post_item_ids_${item.id}" />`;
    $(`#${item.id}`).append(html);
  }

  function addDefaultOption() {
    let html = `<option value="">アイテムを選択してください</option>`
    $(".post-new__form__item-brand__item__select").append(html);
  }


  $("#brand-search-field").on("keyup", function() {
    var input = $("#brand-search-field").val();
    $.ajax({
      type: "GET",
      url: "/brands",
      data: { keyword: input },
      dataType: "json"
    })
    .done(function(brands) {
      $("#brand-search-result").empty();
      $(".post-new__form__item-brand__item__select option").remove('');
      addDefaultOption()

      if (brands.length !== 0) {
        brands.forEach(function(brand) {
          addBrand(brand);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoBrand();
      }
    })
    .fail(function() {
      alert("通信エラーです。ブランドが表示できません。");
    });
  });
  $(document).on("click", ".post-item-brand__name", function() {
    var brandName = $(this).attr("data-brand-name");
    var brandId = $(this).attr("data-brand-id");
    $("#brand-search-result").empty();
    $(".post-item-brand")
      .parent()
      .remove();
    $("#brand-search-field").val(brandName);
    $.ajax({
      type: "GET",
      url: "/items",
      data: { brand_id: brandId },
      dataType: "json"
    })
    .done(function(items) {

      items.forEach(function(item) {
        addItem(item);
      });
    })
    .fail(function() {
      alert("通信エラーです。アイテムが表示できません。");
    });
  });

  $(document).on("click", ".post-new__form__item-brand__decide__btn", function() {
    var itemId = $(".post-new__form__item-brand__item__select option:selected").val();
    var url = `/items/${itemId}`
    if (itemId.length !== 0) {
        $.ajax({
        type: "GET",
        url: url,
        data: { id: itemId },
        dataType: "json"
      })
      .done(function(item) {
        var itemAmount = $('.post-new__form__item-brand__selected > div').length
        if (itemAmount <= 4){
          addPostItem(item)
          addPodtItemForm(item)
          $("#brand-search-field").val('');
          $(".post-new__form__item-brand__item__select option").remove('');
          addDefaultOption()
        }else{}
      })
      .fail(function() {
        alert("通信エラーです。アイテムが取得できません。");
      });
    } else {}
  });





  function readURL1(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#postNewImage1').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_images_attributes_0_image").change(function(){
    readURL1(this);
  });
  $(document).on("click", "#removeImage1", function() {
    var dom = $(this).prevAll('.post-new__form__image__form__box__image').children('img');
    dom.attr('src', '');
    $('#post_images_attributes_0_image').val('');
  });
  


  function readURL2(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#postNewImage2').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_images_attributes_1_image").change(function(){
    readURL2(this);
  });
  $(document).on("click", "#removeImage2", function() {
    var dom = $(this).prevAll('.post-new__form__image__form__box__image').children('img');
    dom.attr('src', '');
    $('#post_images_attributes_1_image').val('');
  });

  function readURL3(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#postNewImage3').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_images_attributes_2_image").change(function(){
    readURL3(this);
  });
  $(document).on("click", "#removeImage3", function() {
    var dom = $(this).prevAll('.post-new__form__image__form__box__image').children('img');
    dom.attr('src', '');
    $('#post_images_attributes_2_image').val('');
  });

  function readURL4(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#postNewImage4').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_images_attributes_3_image").change(function(){
    readURL4(this);
  });
  $(document).on("click", "#removeImage4", function() {
    var dom = $(this).prevAll('.post-new__form__image__form__box__image').children('img');
    dom.attr('src', '');
    $('#post_images_attributes_3_image').val('');
  });
});