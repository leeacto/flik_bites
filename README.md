[![Build Status][BS img]]
<a href='https://coveralls.io/r/eugenefilimonov/final_project?branch=master'><img src='https://coveralls.io/repos/eugenefilimonov/final_project/badge.png?branch=master' alt='Coverage Status' /></a>

[travis pull requests]: https://travis-ci.org/eugenefilimonov/final_project/pull_requests
[BS img]: https://travis-ci.org/eugenefilimonov/final_project.png

# FlikBites

A better menu


# SETUP AND CONFIGURATION

* Ruby version - 1.9.3p194

* Rails version - 4.0.0

* RSpec version - 2.14.5

* System dependencies

* Configuration
	- The database runs on Postgresql, port 5432 in testing and development
	-localhost is 3000

* Database creation
	- Upon cloning the repo, run <tt>bundle install</tt> to prepare the gems for use

* Database initialization
	-Then, run 'rake db:create' to create the database
	-Finally, run <tt>rake db:migrate</tt> to build all necessary tables

* How to run the test suite
	- ##### runs tests through Rspec. Running <tt>rake spec</tt> will cycle through all tests.

* Services
