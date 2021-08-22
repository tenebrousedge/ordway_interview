# README

This is an example project, a minimal demonstration of a toy problem. It currently has no UI.

It's fairly easy to run:

1. Clone the repository and `cd` into it
2. Create the `.env` file (or `cp .env{.sample,}`)
3. Run `docker-compose up`
4. Initialize the database by running `docker-compose exec web rails db:setup`

To run the tests:

1. Create the test database by running `docker-compose exec web rails db:setup RAILS_ENV=test`
2. Invoke the tests with `docker-compose exec web rails test`

You can also avoid using Docker and follow the normal rails process:

1. `bundle install`
2. `rails db:setup`
3. `rails s`

You will of course need to have a local installation of postgresql for the app to use.

## Note:

The Dockerfile assumes that the local user has UID=1000 and GID=1000. These values can probably be overridden in the .env file or in the docker-compose file. This may not be relevant to non-Linux users.
