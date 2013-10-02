class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
    	t.integer :user_id
    	t.integer :restaurant_id
    	t.integer :dish_id
    end
    add_index :user_favorites, :user_id
    add_index :user_favorites, :restaurant_id
    add_index :user_favorites, :dish_id
  end
end
