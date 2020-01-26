class AddReadflgToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :readflg, :boolean, default: false, null: false
  end
end
