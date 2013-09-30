class ChangeStateColumnForRestaurants < ActiveRecord::Migration
  def change
    change_column :restaurants, :state, :string
  end
end


