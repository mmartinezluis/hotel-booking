# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




binding.pry

begin
  puts amadeus.shopping.flight_offers_search.get(originLocationCode: 'NYC', destinationLocationCode: 'MAD', departureDate: '2021-06-01', adults: 1, max: 1).body
rescue Amadeus::ResponseError => error
  puts error
end

hotels_madrid_hash = amadeus.shopping.hotel_offers.get(cityCode: 'MAD')
all_hotels_madrid = hotels_madrid_hash.result
total_hotels_madrid = all_hotels_madrid["data"].length      # Total of 6 hotels
hotels_madrid_locations = hotels_madrid_hash.data
first_hotel_madrid = hotels_madrid_hash.data[0]
first_hotel_madrid_self_key = first_hotel_madrid["self"]










# Querying using dates
trial = amadeus.shopping.hotel_offers.get(
    cityCode: 'NYC',
    checkInDate: "2021-05-18",
    ckeckOutDate: "2021-05-20",
    adults: 1   
).data

confirmation = amadeus.shopping.hotel_offer('TI9BPDX9PK').get.result

