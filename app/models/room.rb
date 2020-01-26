class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def partner(current_user)
    if self.entries[0].user_id != current_user.id
      partner = User.find(self.entries[0].user_id)
    elsif self.entries[1].blank?
      return false
    else
      partner = User.find(self.entries[1].user_id)
    end
  end
end
