# Hotel Booking

## Introduction
Hi, welcome to Hotel Booking. This is the third project for Flatiron school's curriculum sequence. The project involves using Ruby on Rails to build an application that processes data through complex forms using RESTful routes and the MVC framework. Some of the project requirements include: nested forms, nested routes, scope methods, using OmniAuth for user sign in, and proper handling and displaying of errors. 

## Functionality
Hotel Booking uses the [Amadeus Hotel Search API](https://developers.amadeus.com/self-service/category/hotel/api-doc/hotel-search) that comprises more than 150,000 hotels worldwide. The Amadeus API finds the cheapest hotels for a given location. In Hotel Booking users have the ability to:

* Log in to the app by creating a new user account or by OmniAuth authentication through their Google accounts.
* Search for hotel reservations by a given city, check-in date, checkout-date, and number of guests in real-time.
* Book a hotel reservation in real-time (reservations are valid in real-time at moment of booking but booking occurs within the app only). 
* Browse a list of the cities of their booked hotels.
* Browse a list of their booked hotels.
* See a list of their booked hotels at a given city upon click on a city name. 
* See their upcoming and/or previous reservations for a given hotel upon click on the hotel name.
* Write a review for past hotel reservations.
* Edit or delete their hotel reviews. 
* Some more things ...

Video walkthrough on YouTube: https://www.youtube.com/watch?v=sMv64I-NbZU

## Getting Started
To get started with the app, make sure you have Rails installed on your machine. Clone the repo to your local machine:
``` javascript
$ git clone https://github.com/mmartinezluis/hotel-booking.git
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

Run the application migrations's through:
``` javascript
$ rails db:migrate
```

Finally, on the root path run a local server:
``` javascript
$ rails server
```
Open the browser to view application:
```javascript
localhost:3000
```

## Contributing
Contributions and pull requests are welcomed. You can also create an issue to report a bug or make a request. For pull requests, you may follow these steps:
1. Fork and clone the repository.
2. Create a branch name denoting the feature or bug. For example: `git checkout -b feature/new-feature` or `git checkout -b bug/bug-fix`.
3. Write your code and submit changes with a clear commit message.
4. Push to the branch with `git push origin feature/new-feature`. 
5. Create a pull request, and explain the reason for the requested change (why the written code should be implemented).

## License
Hotel Booking is available as open source under the terms of the [MIT License](https://github.com/mmartinezluis/SellBy-Online-Store-Sinatra-Project/blob/main/LICENSE.txt). 

