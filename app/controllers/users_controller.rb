class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow, :follow_list, :follower_list]

  def index
    @users = User.all.page(params[:page]).per(50)
  end

  def show
    @user  = User.find(params[:id])
    @posts = desc(@user.posts)
    @favoriteposts = desc(@user.favorites)
  end

  def follow
    current_user.follow(@user)
    redirect_to request.referrer
  end

  def unfollow
      current_user.stop_following(@user)
      redirect_to request.referrer
  end


  def follow_list
    @follow_users = @user.all_following
  end

  def follower_list
    @user_followers = @user.followers
  end

  def timeline
    posts = Post.where(user_id: current_user.all_following)
    @posts = desc(posts).page(params[:page]).per(12)
    @womenPosts = @posts.select{|post| post.user.gender == 2}
    @menPosts = @posts.select{|post| post.user.gender == 1}
  end

  private

  def desc(posts)
    posts.order(created_at: "DESC")
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
end
