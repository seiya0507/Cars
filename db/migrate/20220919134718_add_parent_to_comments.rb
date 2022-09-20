class AddParentToComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :parent, foreign_key: { to_table: :comments }
  end
end
