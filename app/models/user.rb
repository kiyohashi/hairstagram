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

  def self.search(genderId, lengthId, minage, maxage, salonId, keyword)

    scope :gend, -> { where('(gender_id IN(?))',genderId) if genderId != [""]}
    scope :leng, -> { where('(length_id IN(?))',lengthId) if lengthId.present?}
    scope :minag, -> { where("age >= ?", minage) if minage.present?}
    scope :maxag, -> { where("age <= ?", maxage) if maxage.present?}
    scope :salon, -> { where('(salon_id IN(?))',salonId) if salonId.present?}
    scope :word, -> { where('((name LIKE(?)) OR (acountid LIKE(?)) OR (introduction LIKE(?)))', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%") if keyword.present?}
    scope :searchresults, -> { gend.leng.minag.maxag.salon.word }
    return User.searchresults

  end
end
