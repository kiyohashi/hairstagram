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
end
