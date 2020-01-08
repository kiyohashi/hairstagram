class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :length, null: false
    add_reference :users, :length, null: true
    remove_column :users, :gender, :integer, null: false
    add_reference :users, :gender, null: true
  end
end
