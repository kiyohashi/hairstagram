class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow, :follow_list, :follower_list]
  before_action :authenticate_user!, only: [:timeline, :show]

  def search
    if params[:gender_ids] != [""] || params[:length_id] != "" || params[:minage] != '' || params[:maxage] != '' || params[:salon_id] != '' || params[:keyword] != ''
      if params[:gender_ids].present?
        searchedUsers = User.search(params[:gender_ids],params[:length_id],params[:minage],params[:maxage],params[:salon_id],params[:keyword])
        @users = searchedUsers.page(params[:page]).per(30)
        @usersCount = searchedUsers.count
      elsif params[:keyword].present?
        @users = User.simplesearch(params[:keyword]).page(params[:page]).per(30)
        @usersCount = User.simplesearch(params[:keyword]).count
      else
        @users = User.all.page(params[:page]).per(50)
        @usersCount = User.all.count
      end
    else 
      @users = User.all.page(params[:page]).per(50)
      @usersCount = User.all.count
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
    if params[:keyword] != ''
      @keyword = params[:keyword]
    end
  end

  def show
    @user  = User.find(params[:id])
    @posts = desc(@user.posts)
    
  end
    
  def favorites
    @user  = User.find(params[:id])
    @favoriteposts = desc(@user.favorited_posts)
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
    if  params[:user] == nil
      if current_user.update(icon: '')
        redirect_to user_path(current_user)
      else
        @user = User.find(params[:id])
        render :iconedit
      end
    else
      if current_user.update(user_params)
        redirect_to user_path(current_user)
      else
        @user = User.find(params[:id])
        render :iconedit
      end
    end
  end 

  def emailedit
    @user = User.find(params[:id])
  end

  def emailupdate
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
    messages = Message.where(user_id: current_user.id)
    messages.each do |message|
      message.update(user_id: nil)
    end
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
