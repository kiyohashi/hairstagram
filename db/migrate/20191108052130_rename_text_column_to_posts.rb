class RenameTextColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :text, :body
  end
end
