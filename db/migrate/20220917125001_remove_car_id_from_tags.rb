class RemoveCarIdFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :car_id, :integer
  end
end
