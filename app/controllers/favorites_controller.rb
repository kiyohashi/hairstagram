class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = Favorite.create(favorite_params)
    redirect_to request.referrer
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    redirect_to request.referrer
  end

  private

  def favorite_params
    params.permit().merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
