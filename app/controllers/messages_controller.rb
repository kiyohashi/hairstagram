class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html {redirect_to controller: 'rooms', action: 'show', id: params[:room_id]}
        format.json
      end
    else
      redirect_to controller: 'rooms', action: 'show', id: params[:room_id]
    end
  end

  private

  def message_params
    params.permit(:body, :image, :room_id).merge(user_id: current_user.id)
  end
end
