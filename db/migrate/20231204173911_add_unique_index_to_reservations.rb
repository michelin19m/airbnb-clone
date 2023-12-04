class AddUniqueIndexToReservations < ActiveRecord::Migration[7.1]
  def change
    add_index :reservations, [:property_id, :reservation_date], unique: true
    change_column :reservations, :reservation_date, :date, null: false
  end
end
