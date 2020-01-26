json.body   @message.body
json.image  @message.image.url
json.roomId @message.room.id
json.date   @message.created_at.strftime("%Y/%m/%d %H:%M")

