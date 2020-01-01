class AddColumnToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :age, :integer
    add_reference :posts, :gender
  end
end
