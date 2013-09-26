class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :price
      
      t.timestamps
    end

    add_index :dishes, :name
    add_index :dishes, :price
    add_index :dishes, :category
  end
end
