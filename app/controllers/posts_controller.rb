class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :ranking, :search]

  def index
    @posts = Post.all.page(params[:page]).per(30)
  end

  def search
    if params[:gender_ids] != [""] || params[:length_id] != "" || params[:minage] != '' || params[:maxage] != '' || params[:salon_id] != '' || params[:item_id] != '' || params[:keyword] != ''
      if params[:gender_ids].present?
        searchedPosts = Post.search(params[:gender_ids],params[:length_id],params[:minage],params[:maxage],params[:salon_id], params[:item_id],params[:keyword])
        @posts = searchedPosts.includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
        @postsCount = searchedPosts.count
      elsif params[:keyword].present?
        @posts = Post.simplesearch(params[:keyword]).includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
        @postsCount = Post.simplesearch(params[:keyword]).count
      elsif params[:item_id].present?
        emptygender = [""]
        empty = ''
        searchedPosts = Post.search(emptygender,empty,empty,empty,empty, params[:item_id],empty)
        @posts = searchedPosts.includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
        @postsCount = searchedPosts.count
      elsif params[:salon_id].present?
        emptygender = [""]
        empty = ''
        searchedPosts = Post.search(emptygender,empty,empty,empty, params[:salon_id],empty,empty)
        @posts = searchedPosts.includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
        @postsCount = searchedPosts.count
      else
        @posts = Post.all.includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
        @postsCount = Post.all.count
      end
    else 
      @posts = Post.all.includes(:favorites).order("favorites.post_id DESC").page(params[:page]).per(30)
      @postsCount = Post.all.count
    end


    if params[:gender_ids] && params[:gender_ids] != [""]
      @genders = Gender.where(id: params[:gender_ids])
    end
    if params[:length_id] && params[:length_id] != ''
      @length = Length.find(params[:length_id])
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
    @womenPosts = @posts.select{|post| post.gender_id == 1}
    @menPosts = @posts.select{|post| post.gender_id == 2}
    @freePosts = @posts.select{|post| post.gender_id == 3}
    # postsalons = Salon.joins(:posts).select("id").group(:id).count
    # postsalons_order = Hash[postsalons.sort_by{ |_, v| -v }].keys
    # @popularity_salons = Salon.where(id: postsalons_order).order("FIELD(id, #{postsalons_order.join(',')})").first(5)
    @popularity_salons = Salon.find(Post.group(:salon_id).order('count(salon_id) desc').limit(5).pluck(:salon_id))
    @popularity_users = User.find(Follow.group(:followable_id).order('count(followable_id) desc').limit(5).pluck(:followable_id))
    @popularity_items = Item.find(PostItem.group(:item_id).order('count(item_id) desc').limit(5).pluck(:item_id))
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to root_path
    else
      @post = Post.new(post_params)
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