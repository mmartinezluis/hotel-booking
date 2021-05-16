class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code
      t.integer :guests
      t.decimal :price
      t.string :checkin_date
      t.string :checkout_date
      t.string :room_info
      t.integer :user_id
      t.integer :hotel_id

      t.timestamps
    end
  end
end
