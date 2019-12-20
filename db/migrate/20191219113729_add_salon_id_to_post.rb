class AddSalonIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :salon, foreign_key: true
  end
end
