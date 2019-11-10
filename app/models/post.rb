class Post < ApplicationRecord
  validates :body, :image, presence: true
  mount_uploader :image, ImageUploader

  belongs_to :user
  # has_many :comments
end
