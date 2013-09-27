class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :dish_id
      t.string :photo_url

      t.timestamps
    end
  end
end
