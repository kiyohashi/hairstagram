class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :ranking, :search]

  def index
    @posts = Post.all.page(params[:page]).per(30)
  end

  def search
    if params[:gender_ids] != [""] || params[:minage] != '' || params[:maxage] != '' || params[:salon_id] != '' || params[:item_id] != '' || params[:keyword] != ''
      if params[:gender_ids].present?
        searchedPosts = Post.search(params[:gender_ids],params[:minage],params[:maxage],params[:salon_id], params[:item_id],params[:keyword])
        @posts = searchedPosts.page(params[:page]).per(30)
        @postsCount = searchedPosts.count
      elsif params[:keyword].present?
        @posts = Post.simplesearch(params[:keyword]).page(params[:page]).per(30)
        @postsCount = Post.simplesearch(params[:keyword]).count
      else
        @posts = Post.all.page(params[:page]).per(30)
        @postsCount = Post.all.count
      end
    else 
      @posts = Post.all.page(params[:page]).per(30)
      @postsCount = Post.all.count
    end

    if params[:gender_ids] != [""]
      @genders = Gender.where(id: params[:gender_ids])
    end
    if params[:minage] != ''
      @minage = params[:minage]
    end
    if params[:maxage] != ''
      @maxage = params[:maxage]
    end
    if params[:salon_id] && params[:salon_id] != ''
      @salon = Salon.find(params[:salon_id])
    end
    if params[:item_id] && params[:item_id] != ''
      @item = Item.find(params[:item_id])
    end
    if params[:keyword] != ''
      @keyword = params[:keyword]
    end
    
  end

  def ranking
    post_like_count = Post.joins(:favorites).group(:post_id).count
    post_liked_ids = Hash[post_like_count.sort_by{ |_, v| -v }].keys
    @posts = Post.where(id: post_liked_ids).order(['field(id, ?)', post_liked_ids])
    @womenPosts = @posts.select{|post| post.user.gender_id == 1}
    @menPosts = @posts.select{|post| post.user.gender_id == 2}
    @freePosts = @posts.select{|post| post.user.gender_id == 3}
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    post = Post.new(post_params)
    binding.pry
    if post.save
      redirect_to root_path
    else
      @post = Post.new
      @post.images.build
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
    params.require(:post).permit(:title, :body, :salon_id, :length_id, :gender_id, :age, item_ids: [], images_attributes:[:image]).merge(user_id: current_user.id)
  end

  def  move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end