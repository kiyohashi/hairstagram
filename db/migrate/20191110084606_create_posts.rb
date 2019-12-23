class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.text :body, null:false
      t.references :user, null:false, foreign_key: true
      t.references :length, null:false
      t.timestamps
    end
  end
end
