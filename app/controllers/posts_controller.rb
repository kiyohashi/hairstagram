class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def show
    @post      = Post.find(params[:id])
    @comment   = Comment.new
    @comments  = @post.comments.includes(:user)
    @favorite  = Favorite.new
    @favorites = @post.favorites.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:image, :body, :title).merge(user_id: current_user.id)
    # salon,gender,style 追加
  end

  def  move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

