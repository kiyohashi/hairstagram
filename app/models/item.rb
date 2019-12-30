class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to :brand
  has_many :post_items
  has_many :posts,      through: :post_items

end
