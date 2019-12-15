class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :icon, ImageUploader
  acts_as_followable
  acts_as_follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
         
  has_many :posts
  has_many :favorites
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # def update_without_current_password(params, *options)
  #   params.delete(:current_password)

  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end

  #   result = update_attributes(params, *options)
  #   clean_up_passwords
  #   result
  # end
end
