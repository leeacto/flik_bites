class AddRestaurantIdToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :restaurant_id, :integer, index: true
  end
end
