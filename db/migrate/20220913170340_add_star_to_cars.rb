class AddStarToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :star, :string
  end
end
