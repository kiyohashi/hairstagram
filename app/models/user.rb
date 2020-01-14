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
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
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

  def icon_judge
    if self.icon.present?
      return self.icon.url
    else
      return "egg-icon-gray.png"
    end
  end
  

  def commonfollows(current_user)
    userfollows = current_user.all_following
    commonfollows = Follow.where(followable_id: userfollows).where.not(follower_id: userfollows).where.not(follower_id: current_user.id)
  end

  def commonfollowcount(current_user)
    userfollows = current_user.all_following
    commonfollows = Follow.where(followable_id: userfollows).where.not(follower_id: userfollows).where.not(follower_id: current_user.id)
    recommendusers_count = commonfollows.group(:follower_id).count(:follower_id)
    recommendusers_order = Hash[recommendusers_count.sort_by{ |_, v| -v }]
    recommendusers_order.each{|key, value|
      if key = self.id
        return value
      end
    }
  end
end
