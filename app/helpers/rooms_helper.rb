module RoomsHelper
  def unreadcount(room)
    room.messages.where("(user_id = ?) AND (readflg = ?)", room.partner(current_user),false).count
  end


  def notification_count
    count = 0
    current_user.rooms.each do |room|
      count += unreadcount(room)
    end
    return count
  end
end
