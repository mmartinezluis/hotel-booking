# Hotel Booking

<kbd>
<img src="https://user-images.githubusercontent.com/75151961/206912626-081da6f9-c6df-43a9-ad63-23f2ffdf930a.png" alt="Hotel Booking hotel search page">
</kbd>
&nbsp;

## Introduction
Hotel Booking is a full-stack Ruby on Rails app for making hotel reservations worldwide. Hotel Booking follows the MVC (models-views-controllers) architecture to render code on its pages, and utlizes RESTful API conventions for serving the data needed in the frontend. Hotel Booking utilizes models associations involving cities, hotels, reservations, and reviews to produce a rich user experience.

## Functionality
Hotel Booking consumes the [Amadeus Hotel Search API](https://developers.amadeus.com/self-service/category/hotel/api-doc/hotel-search) that comprises 150,000+ hotels worldwide to display real-time hotel offers for the selected city, checkin-date, checkout-date, and numbers of guests in the hotel search form. Hotel<-- Reservation<-- Room double-nested objects are built on the fly during the search process, and are persisted to the database only when a reservation is made to optimze database storage space. When clicking on "Reserve" for a given offer, the offer availability is checked in real-time: if the offer is still avaialble, the booking is made, otherwise a no-longer-available message is displayed.

Model associations along with nested routes and partials are used to produce a net of interconnected views allowing the user to access a variety of information from multiple sources. For example, a user can access a given hotel page from the hotels index page, the reservations index page, or the cities index page. Also, a user can access the new review form from a hotel show page, the reservations index page or the reviews index page. 

Reservations open for review past 24 hours of the reservation's checkout date. Accessing the reservations index page will show your upcoming and/or previous reservations, and a "New Review" link is dynamically shown on the page if you have reservations that are open for review, which takes you to the new review form. 

The app counts with a Trending page, which features the top-three most reserved hotels in the app. You can login to the app via email and password or using your Gmail account. 

## Deployment
Hotel Booking has yet been deployed to production as I'm going to use it as an opportunity to learn and use infrastructure as code tools, CI/CD tools, and containerization tools (Terraform, Kafka, Docker, Kuberetes), and apply software architecture design principles to make a higly-avialable and higly-scalable system in the cloud. 

## Demo
You can find here rich [demo images](https://github.com/mmartinezluis/hotel-booking/issues/1) and a [video walkthrough](https://www.youtube.com/watch?v=p1-Fz3bk0QE&t=7s) of the app. 


## Developing Locally
To run the app in your machine, first make sure you have Rails installed. Then: 
1. Clone the repo to your local machine:
``` ruby
$ git clone https://github.com/mmartinezluis/hotel-booking.git
```

2. Install the needed gems:
``` ruby
$ bundle install
```

3. Follow Amadeus' Self-Service APIs [instructions](https://developers.amadeus.com/get-started/get-started-with-self-service-apis-335) to obtain an Amadeus API key and secret.

4. Create a new file in the main directory of this repository in your local machine called `.env`

5. Then, in this `.env` file include the following lines, replacing "MY_API_KEY" and "MY_API_SECRET" with your API key and API secret, respectively:

```
AMADEUS_API_KEY = MY_API_KEY

AMADEUS_API_SECRET = MY_API_SECRET
```

6. Run the application migrations's through:
``` ruby
$ rails db:migrate
```

7. Run the dabase seed so that the hotel search form can load the IATA city codes used for hotel search:
```ruby
$ rails db:seed
```

8. Finally, on the root path run a local server:
``` ruby
$ rails server
```

9. Open your browser at `http://localhost:3000` to run the app.

## Contributing
Contributions and pull requests are welcomed. You can also create an issue to report a bug or make a request. For pull requests, you may follow these steps:
1. Fork and clone the repository.
2. Create a branch name denoting the feature or bug. For example: `git checkout -b feature/new-feature` or `git checkout -b bug/bug-fix`.
3. Write your code and submit changes with a clear commit message.
4. Push to the branch with `git push origin feature/new-feature`. 
5. Create a pull request, and explain the reason for the requested change (why the written code should be implemented).

## License
Hotel Booking is available as open source under the terms of the [MIT License](https://github.com/mmartinezluis/hotel-booking/blob/main/LICENSE.md). 

