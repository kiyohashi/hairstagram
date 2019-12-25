class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name
      t.text       :link
      t.text       :image_url
      t.references :genre, null:false
      t.references :brand, null:false
      t.timestamps
    end
  end
end
