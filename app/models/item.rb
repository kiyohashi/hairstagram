class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to :brand
  has_many :post_items
  has_many :posts,      through: :post_items

  def self.search(brandId, keyword, genreId) 
    scope :brand, -> { where('(brand_id IN(?))',brandId) if brandId.present?}
    scope :word, -> { where('(name LIKE(?))', "%#{keyword}%") if keyword.present?}
    scope :genre, -> { where('(genre_id IN(?))',genreId) if genreId.present?}
    scope :searchresults, -> { brand.word.genre }
    return Item.searchresults
  end
end
