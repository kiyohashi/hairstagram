class TimelinesController < ApplicationController
  before_action :recommend_users
  before_action :set_posts

  def all
    @posts = @followposts.page(params[:page]).per(15)
    render :timeline
  end

  def women
    womenPosts = @followposts.select{|post| post.gender_id == 1}
    @posts = Kaminari.paginate_array(womenPosts).page(params[:women_page]).per(15)
    render :timeline
  end

  def men
    menPosts = @followposts.select{|post| post.gender_id == 2}
    @posts = Kaminari.paginate_array(menPosts).page(params[:men_page]).per(15)
    render :timeline
  end

  def free
    freePosts = @followposts.select{|post| post.gender_id == 3}
    @posts = Kaminari.paginate_array(freePosts).page(params[:free_page]).per(15)
    render :timeline
  end

  private

  def recommend_users
    @recommendusers = User.find(current_user.commonfollows(current_user).group(:follower_id).order('count(follower_id) desc').limit(5).pluck(:follower_id))
  end

  def set_posts
    @followposts = Post.where(user_id: current_user.all_following).order(created_at: "DESC")
  end
end
