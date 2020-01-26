class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    allRoom = Room.all
    allRoom.each do |room|
      userIds = []
      room.entries.each do |entry|
        userIds << entry.user_id
      end
      if userIds.include?(current_user.id) && userIds.include?(params[:user_id].to_i)
        redirect_to action: 'show', id: room.id
        return
      end
    end
    @room = Room.create
    entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    entry2 = Entry.create(params.permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to action: 'show', id: @room.id
  end

  def show
    @rooms = current_user.rooms.order(updated_at: "desc")
    @room = Room.find(params[:id])
    if @room.partner(current_user)
      @room.partner(current_user).messages.each do |message|
        message.update(readflg: true)
      end
    end
  end

  def index
    @rooms = current_user.rooms.order(updated_at: "desc")
  end
  
end
