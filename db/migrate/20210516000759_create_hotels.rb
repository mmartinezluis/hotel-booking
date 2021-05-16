class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :hotelId
      t.string :citycode
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.text :description
      t.string :amenities

      t.timestamps
    end
  end
end
