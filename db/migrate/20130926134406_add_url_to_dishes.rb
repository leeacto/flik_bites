class AddUrlToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :url, :string
  end
end
