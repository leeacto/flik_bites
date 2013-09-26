class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :state
      t.string :zip
      t.string :cuisine
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :restaurants, :zip
    add_index :restaurants, :city
    add_index :restaurants, :cuisine
  end
end
