# TransitService

#### API service that provides transit data, 08.25.2017

#### By _**Patrick McGreevy**_

## Description
This project is an API that provides transit data.

## API Documentation
### Version 1
(Note: include `"version=1"` in Accept header for requests)

#### Schedule table
`route_directions/:id/schedule?&service_id`
`id`: id of route_direction requested

Get aligned rows of stop_times under a service

```
response =  "{",
            "id:", integer,
            ", route_id:", integer,
            ", direction_id:", ("0" | "1"),
            ", direction_name:", string,
            ", service:", service,
            ", stops_list:", stops_list,
            ", trips:", trips,
            "}" ;
service = "{ name:", string, "}" ;
stops_list = "[", { stop, "," }, stop, "]" ;
stop = "{ id:", integer, ", name:", string, ", local_id:", string, "}" ;
trips = "[ ", { trip, "," }, trip, "]" ;
trip = "{ stop_times: [", { ( integer | null ), "," }, ( integer | null ), "] }" ;
```
(EBNF)


## Setup
1. Set project root as working directory in CLI after cloning repo.
2. Run `$ bundle install`
3. Run `$ rake db:setup`
4. Run `$ rake trimet:all`
5. Run `$ postgres`.
6. Run `$ rails s`.
7. Visit **`localhost:3000`**  in web browser.
8. Open Postman and enter requests at **`localhost:3000`**.


## Project creation

* `$ rails new transit_service --api`
* `$ cd transit_service`
* `$ bundle install`
* `$ rails g rspec:install`
* `$ rake db:create`
* `$ rails g migration create_agencies`
* `$ rails g migration create_routes`
* `$ rails g migration create_route_directions`
* `$ rails g migration create_stops`
* `$ rails g migration create_trips`
* `$ rails g migration create_stop_times`
* `$ rails g migration update_trips`
* `$ rails g migration add_indices`
* `$ rails g migration alter_trips`
* `$ rails g migration alter_tables`
* `$ rails g migration add_service_id`
* `$ rails g migration create_services`
* `$ rails g migration add_service_id_index`
* `$ rails g migration create_locations`
* `$ rails g migration update_stops`
* `$ rake db:migrate`



## Technologies Used

* Ruby/Gems
* Rails
* PostgreSQL
* JSON


## Specs

* Provide TriMet's WES and MAX schedule data.
* Provide schedule data with trips ordered such that every stop's column in the schedule has ascending arrival time.
* Provide merged schedule data for multiple route_directions, ordered properly.
* Provide routing solutions between WES stations.
* Create Gem for parsing TriMet's GTFS into API's database.
* Provide routing between WES/MAX stations on generic weekday, using [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm).
  * Manually enter transfer connections, e.g. Pioneer Square, Rose Quarter (TC & Interstate), Gateway TC, Beaverton TC
* Complete API documentation.



## Testing

* Run `$ rspec`


## Known Bugs

_No known bugs._

## Support
_Please contact patrick7490@icloud.com with questions or concerns._


### License

*MIT License*

Copyright (c) 2017 _**Patrick McGreevy**_
