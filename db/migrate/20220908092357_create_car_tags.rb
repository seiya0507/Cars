class CreateCarTags < ActiveRecord::Migration[6.1]
  def change
    create_table :car_tags do |t|

      t.integer :car_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end
