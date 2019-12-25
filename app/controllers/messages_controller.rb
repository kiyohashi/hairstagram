class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Message.create(message_params)
    redirect_to controller: 'rooms', action: 'show', id: params[:room_id]
  end

  private

  def message_params
    params.permit(:body, :image, :room_id).merge(user_id: current_user.id)
  end
end
