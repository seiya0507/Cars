class CreateFreezes < ActiveRecord::Migration[6.1]
  def change
    create_table :freezes do |t|

      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
