class CreateDownVotePhotos < ActiveRecord::Migration
  def change
    create_table :down_vote_photos do |t|
      t.integer :user_id
      t.integer :photo_id

      t.timestamps
    end
    add_index :down_vote_photos, :user_id
    add_index :down_vote_photos, :photo_id
  end
end
