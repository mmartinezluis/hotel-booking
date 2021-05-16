class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code
      t.integer :guests
      t.string :currency
      t.decimal :price
      t.string :checkin_date
      t.string :checkout_date
      t.integer :user_id
      t.integer :hotel_id

      t.timestamps
    end
  end
end
