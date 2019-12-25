class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :ranking, :search]

  def index
    @posts = Post.all.page(params[:page]).per(30)
  end

  def search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(30)
  end

  def ranking
    post_like_count = Post.joins(:favorites).group(:post_id).count
    post_liked_ids = Hash[post_like_count.sort_by{ |_, v| -v }].keys
    @posts = Post.where(id: post_liked_ids).order(['field(id, ?)', post_liked_ids])
    @womenPosts = @posts.select{|post| post.user.gender == 2}
    @menPosts = @posts.select{|post| post.user.gender == 1}
    @freePosts = @posts.select{|post| post.user.gender == 3}
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    if Post.create(post_params)
      redirect_to root_path
    else
      render :new
    end
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
    params.require(:post).permit(:title, :body, :salon_id, :length_id, images_attributes:[:image]).merge(user_id: current_user.id)
    # salon,gender,style 追加
  end

  def  move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

