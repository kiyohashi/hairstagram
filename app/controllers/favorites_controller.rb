class FavoritesController < ApplicationController

  def create
    favorite = Favorite.create(favorite_params)
    redirect_to request.referrer
    # redirect_to :back
    # redirect_to post_path(favorite.post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    # redirect_to post_path(@post)
    redirect_to request.referrer
    # redirect_to :back
  end

  private

  def favorite_params
    params.permit().merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
