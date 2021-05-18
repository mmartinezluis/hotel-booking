# README
Hi, welcome to my Hotel Booking project. This is the third project in Flatiron school's curriiculum sequence. THe project involves using Ruby on Rails to build an application that processes data through complex forms using RESTful routes and the MVC framework. Some of the project requirements include nested forms, nested routes, scope methods, using OmniAuth for user sign in, and proper handling and displaying of errors. 

Hotel Booking uses the [Amadeus Hotel Search API](https://developers.amadeus.com/self-service/category/hotel/api-doc/hotel-search) that comprises more than 150,000 hotels worlwide. The Amadeus API finds the cheapest hotels for a given location. The following are the user stories for Hotel Booking:

* Users can log in to the app by creating a new user account or by using 
* Users can search for hotel reservations by a given city, check-in date, checkout-date, and number of guests in real-time.
* Users can verify the availability of a given hotel reservation in real-time.
* Users can book a reservation (feature managed by ActiveRecord; reservations are valid at time of booking but booking is not real). 
* Users can browser their visited countries, cities, and hotels.
* Users can create a new review for past hotel reservations.
* Users can edit or delete their reviews.
* Admin users can start a hotel search with a pre-existing or newly created user already loaded in the database for a fast hotel booking process.
* Admin users can create a new user right before booking a reservation.

Hotel Booking is currently under development and it suports the following functionalities:
* Users can find hotel reservations by a given city in real-time.
* Users can verify the availability of a reservation in real-time and can book a reservation. 

# H1 Getting Started
To get started with the app, make sure you have Rails and Git installed on your machine. Clone the repo to your local machine:
``` javascript
$ git clone https://github.com/mmartinezluis/hotel-booking
```

Install the needed gems:
``` javascript
$ bundle install
```

Follow Amadeus' Self-Service APIs [instructions](https://developers.amadeus.com/get-started/get-started-with-self-service-apis-335) to obtain an Amadeus API key and secret.

Create a new file in the main directory of this repository in your local machine called

```
.env
```

Then, in this `.env` file include the following lines, replacing "API_KEY" and "API_SECRET" with your API key and API secret, respectively:

```
AMADEUS_API_KEY = API_KEY

AMADEUS_API_SECRET = API_SECRET
```

Finally, on the root path run a local server:
``` javascript
$ rails server
```
Open browser to view application:
```javascript
localhost:3000
```



