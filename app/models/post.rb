class Post < ApplicationRecord
  validates :body, :image, :title, presence: true
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
end
