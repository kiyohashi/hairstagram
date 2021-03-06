$(function(){
  if ($('.direct-message__show__messages')[0]) {
    $('.direct-message__show__messages').animate({ scrollTop: $('.direct-message__show__messages')[0].scrollHeight},1);
  }
  
  function simpleFormat(str) {
    str = str.replace(/\r\n?/, "\n");
    str = $.trim(str);
    if (str.length > 0) {
      str = str.replace(/\n\n+/g, '</p><p>');
      str = str.replace(/\n/g, '<br />');
      str = '<p>' + str + '</p>';
    }
    return str;
  }
  function buildHTML(message){
    var body = message.body ? `${ message.body }` : "";
    if (message.image == null) {
      var img = ''
    } else {
      var img =`<img src =${message.image}></img>`
    }
    var html = `<div class="own-message">
                  <div class="direct-message__show__messages__message">
                    <div class="direct-message__show__messages__message__contents">
                      ${simpleFormat(body)}
                      ${img}
                    </div>
                  </div>
                  <div class="direct-message__show__messages__date">
                    ${message.date}
                  </div>
                </div>`
    return html;
  };

  function buildLastMessage(message) {
    if ( message.image ){
      var contents = "画像が送信されました。";
    } else {
      var contents = message.body.replace(/\n.*/m, "").slice(0,20);
    }
    return contents
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      var lastMessage = buildLastMessage(data)
      $(`#room${data.roomId} > .room__right > .room__right__bottom`).empty();
      $(`#room${data.roomId} > .room__right > .room__right__bottom`).append(lastMessage);
      $('.direct-message__show__messages').append(html)
      $('#new_message').get(0).reset();
      $('.direct-message__show__messages').animate({ scrollTop: $('.direct-message__show__messages')[0].scrollHeight});
    })
    .fail(function(){
      alert('error');
    });
    return false;
  });
});