module RoomsHelper
  def partner(room)
    if room.entries[0].user_id != current_user.id
      partner = User.find(room.entries[0].user_id)
    else
      partner = User.find(room.entries[1].user_id)
    end
  end
end