class AddSalonIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :salon, foreign_key: true
  end
end
