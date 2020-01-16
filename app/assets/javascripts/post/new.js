$(function() {

  $(document).ready(function() { 
    var itemIds = $('.post-items-id').map(function(){
      return $(this).val()
    }).toArray()
    itemIds.forEach(function(itemId){
      addItems(itemId)
    });
    var salonId = $('#content_id').val()
    var salonName = $('.post-salon-name').val()
    if ($(".post-salon-name")[0]) {
      $('.searchbox__form__salon-selected').css('height','3rem');
      var html = `
        <div class='searchbox__form__selected__bgc'>
        <span>×
        </div>
        <span id='salon-selected' data-id=${salonId}>${salonName}
      `;
      $('.searchbox__form__salon-selected').append(html);
    }
    var checked = $("input[name='post[gender_id]']:checked").parent();
    addlength(checked)

    var lengthId = $('#length_id').val()
    var lengthName = $('.post-length-name').val()
    if ($(".post-length-name")[0]) {
      $('.searchbox__form__length-selected').css('height','3rem');
      var html = `
        <div class='searchbox__form__selected__bgc'>
        <span>×
        </div>
        <span id='length-selected' data-id=${lengthId}>${lengthName}
      `;
      $('.searchbox__form__length-selected').append(html);
    }
  });

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
    if (item.image == '?target=70x70') {
      var img = '/assets/noimage-748452af927c706a490bee358b8f897f7d0f7843abf07af76dec1009024fc612.jpg'
    } else {
      var img = item.image
    }
    let html = `<div class="modal__item__items__item" data-item-id="${item.id}">
                  <div class="modal__item__items__item__img">
                    <img src="${img}">
                  </div>
                  <div class="modal__item__items__item__brand">
                    ${item.brand}
                  </div>
                  <div class="modal__item__items__item__name">
                    ${item.name}
                  </div>
                </div>`
    $(".modal__item__items").append(html);
  }

  function addPostItem(item) {
    if (item.image == '?target=70x70') {
      var img = '/assets/noimage-748452af927c706a490bee358b8f897f7d0f7843abf07af76dec1009024fc612.jpg'
    } else {
      var img = item.image
    }
    let html = `
                <div class = 'add-item' id = "${item.id}">
                  <div class = 'add-item__delete'>
                    ×
                  </div>
                  <div class = 'add-item__image'>
                    <img src = ${img}>
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
    var itemAmount = $('.post-new__form__item-brand__selected > div').length
    if (itemAmount <= 4){
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
    };
  });

  $(document).on("click", ".post-item-brand__name", function() {
    $('.modal__item__items').children().remove();
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
      $('.modal').css('display','block');
      $('.modal__item').css('display','block');
      $('.modal__salon').css('display','none');
      items.forEach(function(item) {
        addItem(item);
      });
    })
    .fail(function() {
      alert("通信エラーです。アイテムが表示できません。");
    });
  });

  $(document).on("click", ".add-item__delete", function() {
    $(this).parent().remove()
  });

  $(document).on("click", ".modal__item__items__item", function() {
    $('.modal').css('display','none');
    var itemId = $(this).attr("data-item-id");
    addItems(itemId)
  });
  function addItems(itemId) {
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
  };
 
  $(document).on("click", ".modal-delete", function() {
    $('.modal').css('display','none');
  });

  $(document).on("click", ".area-content", function() {
    var pathname= location.pathname;
    if (pathname.indexOf("/posts/new") === 0) {
      $('.modal').css('display','block');
      $('.modal__salon').css('display','block');
    }
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
  
  
  
  
  
  $(".searchbox__form__radio > label").click(function () {
    addlength($(this))
  });
  function addlength(checked) {
    $(".searchbox__form__length-selected").children().remove();
    $(".searchbox__form__select #length_id").val('');
    $('.searchbox__form__length-selected').css('height','0');
    $('#Women-contents').children().css('display','none');
    $('#Men-contents').children().css('display','none');
    $('#nogender').css('display','block');
    var genderid = checked.attr('for')
  
    if (genderid == "post_gender_id_1") {
      $('#Women-contents').children().css('display','block');
      $('#nogender').css('display','none');
    } else if (genderid == "post_gender_id_2") {
      $('#Men-contents').children().css('display','block');
      $('#nogender').css('display','none');
    } else {
      $('#Women-contents').children().css('display','block');
      $('#Men-contents').children().css('display','block');
      $('#nogender').css('display','none');
    }
  }
});