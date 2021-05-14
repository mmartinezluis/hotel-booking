# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




binding.pry

# response = RestClient.get("https://api.spacexdata.com/v4/launches")
# launches = JSON.parse(response)
# first_launch = launches.first

# response = RestClient.get("url/auth= #{ENV["KEY"]}",
#     headers: ENV['KEY']
#     x-api-key: ENV['KEY']
# )

# brreds_array = JSON.parse(response)

carbon_response = RestClient.get("https://www.carboninterface.com/api/v1/auth",
  Authorization: Bearer ENV['CARBON_KEY']"
)


