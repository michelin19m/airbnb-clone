class AddUniqueIndexTiFavorites < ActiveRecord::Migration[7.1]
  def change
    add_index :favorites, [:property_id, :user_id], unique: true
  end
end
