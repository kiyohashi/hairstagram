class CreateSalons < ActiveRecord::Migration[5.2]
  def change
    create_table :salons do |t|
      t.string     :name
      t.string     :nameKana
      t.string     :address
      t.string     :access
      t.text       :link
      t.text       :image_url
      t.text       :introduction
      t.timestamps
    end
  end
end
