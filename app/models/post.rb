class Post < ApplicationRecord
  validates :body, :images, :title, presence: true

  belongs_to :user
  belongs_to :salon
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
  has_many :images
  accepts_nested_attributes_for :images
  
end
