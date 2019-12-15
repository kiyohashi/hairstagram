class UsersController < ApplicationController
  def show
    @user  = User.find(params[:id])
    @posts = @user.posts
    @favoriteposts = @user.favorites
    # binding.pry

    # @favoriteposts = []
    # favoriteposts.each do |favoritepost|
    #   @favoriteposts << Post.where(id: favoritepost.post_id)
    # end
    # binding.pry
    # @favorites = @user.favorites.includes(:post)
    # @favoritesposts = @favorites.posts
  end

  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    # redirect_to user_path(@user)
  end

  def unfollow
      @user = User.find(params[:user_id])
      current_user.stop_following(@user)
      # redirect_to :back
      # redirect_to user_path(@user)
  end


  def follow_list
    @user = User.find(params[:user_id])
  end

  def follower_list
    @user = User.find(params[:user_id])
  end
end
