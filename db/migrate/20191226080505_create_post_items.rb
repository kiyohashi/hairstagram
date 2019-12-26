class CreatePostItems < ActiveRecord::Migration[5.2]
  def change
    create_table :post_items do |t|
      t.references :post, null:false, foreign_key: true
      t.references :item, null:false, foreign_key: true
      
      t.timestamps
    end
  end
end
