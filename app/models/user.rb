class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  mount_uploader :icon, IconUploader
  acts_as_followable
  acts_as_follower

  belongs_to_active_hash :gender
  belongs_to_active_hash :length
  belongs_to :salon , optional: true
  has_many :posts
  has_many :favorites
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments
  has_many :entries, dependent: :destroy
  has_many :messages
  has_many :rooms, through: :entries

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end
end
