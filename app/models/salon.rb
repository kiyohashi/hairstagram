class Salon < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  has_many :posts
  has_many :users

  def self.search(keyword, area) 
    scope :word, -> { where('((nameKana LIKE(?)) OR (name LIKE(?)))', "%#{keyword}%", "%#{keyword}%") if keyword.present?}
    scope :are, -> { where('(area_id IN(?))',area) if area.present?}
    scope :searchresults, -> { word.are }
    return Salon.searchresults
  end
end
