class Post < ApplicationRecord
  validates :body, :image, presence: true
  # belongs_to :user
  # has_many :comments
end
