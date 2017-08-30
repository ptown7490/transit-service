# TransitService

#### API service that provides transit data, 08.25.2017

#### By _**Patrick McGreevy**_

## Description
This project is an API that provides transit data.


## Setup
1. Set project root as working directory in CLI after cloning repo.
2. Run `$ bundle install`
3. Run `$ rake db:setup`
4. Run `$ rails s`.
5. Visit **`localhost:3000`**  in web browser.


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
* `$ rake db:migrate`



## Technologies Used

* Ruby/Gems
* Rails
* PostgreSQL


## Specs

* Provide TriMet's WES schedule data.
* Provide routing solutions between WES stations.


## Testing

* Run `$ rspec`


## Known Bugs

_No known bugs._

## Support
_Please contact patrick7490@icloud.com with questions or concerns._


### License

*MIT License*

Copyright (c) 2017 _**Patrick McGreevy**_
