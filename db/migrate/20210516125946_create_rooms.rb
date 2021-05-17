class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :category
      t.integer :beds
      t.string :bedtype
      t.integer :reservation_id

      t.timestamps
    end
  end
end
