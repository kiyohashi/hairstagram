class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :length
  belongs_to_active_hash :gender
  validates :body, :images, :title, :gender_id, :length_id, :salon_id, :age, presence: true

  belongs_to :user
  belongs_to :salon
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :post_items, dependent: :destroy
  has_many :items,      through: :post_items
  accepts_nested_attributes_for :images
  
  def self.simplesearch(keyword)
    Post.where('((title LIKE(?)) OR (body LIKE(?)))', "%#{keyword}%", "%#{keyword}%")
  end
  
  def self.search(genderId, lengthId, minage, maxage, salonId, itemId, keyword)
    postitems = PostItem.where(item_id: itemId)
    postIds = []
    postitems.each do |postitem|
      postIds << postitem.post_id
    end
    scope :gend, -> { where('(gender_id IN(?))',genderId) if genderId != [""]}
    scope :leng, -> { where('(length_id IN(?))',lengthId) if lengthId.present?}
    scope :minag, -> { where("age >= ?", minage) if minage.present?}
    scope :maxag, -> { where("age <= ?", maxage) if maxage.present?}
    scope :salon, -> { where('(salon_id IN(?))',salonId) if salonId.present?}
    scope :item, -> { where(id: postIds) if postIds.present?}
    scope :word, -> { where('((title LIKE(?)) OR (body LIKE(?)))', "%#{keyword}%", "%#{keyword}%") if keyword.present?}
    scope :searchresults, -> { gend.leng.minag.maxag.salon.item.word }
    return Post.searchresults

  end
  
end
