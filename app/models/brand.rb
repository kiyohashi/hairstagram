class Brand < ApplicationRecord
  has_many :items

  def self.search(input)
    return nil if input == ""
    Brand.where(['name LIKE ?', "%#{input}%"] ).limit(5)
    # Brand.where('((name LIKE(?)) OR (company LIKE(?)))', "%#{keyword}%", "%#{keyword}%").limit(5)
  end

end
