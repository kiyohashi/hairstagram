class Brand < ApplicationRecord
  has_many :items

  def self.search(brandkeyword)
    scope :word, -> { where('((name LIKE(?)) OR (company LIKE(?)))', "%#{brandkeyword}%", "%#{brandkeyword}%") if brandkeyword.present?}
    return Brand.word
  end
  def self.postsearch(input)
    return nil if input == ""
    Brand.where(['name LIKE ?', "%#{input}%"] )
    # Brand.where('((name LIKE(?)) OR (company LIKE(?)))', "%#{keyword}%", "%#{keyword}%").limit(5)
  end

end
