class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :length
  validates :body, :images, :title, presence: true

  belongs_to :user
  belongs_to :salon
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
  has_many :images
  has_many :items,      through: :post_items
  has_many :post_items
  accepts_nested_attributes_for :images
  
  def self.search(keyword)
    return Post.all unless keyword
    Post.where('((title LIKE(?)) OR (body LIKE(?)))', "%#{keyword}%", "%#{keyword}%")
  end

end
