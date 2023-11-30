class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :headline
      t.string :city
      t.string :state
      t.string :country
      t.string :addres_1
      t.string :addres_2

      t.timestamps
    end
  end
end
