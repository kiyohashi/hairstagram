class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow, :follow_list, :follower_list]

  def search
    @users = User.all.page(params[:page]).per(50)
    @usersallcount = User.all.count
  end

  def show
    @user  = User.find(params[:id])
    @posts = desc(@user.posts)
    @favoriteposts = desc(@user.favorites)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])
      render :edit
    end
  end

  def iconedit
    @user = User.find(params[:id])
  end

  def iconupdate
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])
      render :iconedit
    end
  end 

  def emailedit
    @user = User.find(params[:id])
  end

  def emailupdate
    binding.pry
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])
      render :emailedit
    end
  end

  def passwordedit
    @user = User.find(params[:id])

  end

  def passwordupdate
    current_user.password =
    current_user.password_confirmation =
    if current_user.save
      redirect_to user_path(current_user)
    else
      render :emailedit
    end
  end

  def destroyconfirmation
    @user = User.find(params[:id])
  end

  def destroy
    if current_user.destroy
      redirect_to root_path
    else
      @user = User.find(params[:id])
      redirect_to action: 'destroyconfirmation', id: current_user.id
    end
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
    @womenPosts = @posts.select{|post| post.user.gender_id == 1}
    @menPosts = @posts.select{|post| post.user.gender_id == 2}
    @freePosts = @posts.select{|post| post.user.gender_id == 3}
  end

  private

  def desc(posts)
    posts.order(created_at: "DESC")
  end

  def user_params
    params.require(:user).permit(:name, :acountid, :salon_id, :length_id, :icon, :gender_id, :email, :age, :introduction)
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
end
