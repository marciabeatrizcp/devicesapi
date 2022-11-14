# Devices API

## Requirements:
  * run this command `asdf install` 
  * docker >= 20.10.12
  * docker-compose
  * Elixir 1.14.0-otp-24
  * Erlang 24.3.4.5
  

## Quick Start
  * Clone or download this repository
  * Go inside of directory,  `cd devicesapi`
  * Run this command `docker-compose up -d` to start database
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or `iex -S mix phx.server`

## Access to postgres: 
* `localhost:5432`
* **database dev:** devices_api_dev
* **Username:** postgres
* **Password:** postgres

## Access to PgAdmin: 
* Open `http://localhost:5050`
* use `admin` when password will be required
* In Servers, go to Register - Server
* General - Name: localhost
* Connection - Host name/address: db (Use the same name of service in docker-compose.yml to postgres)
* Connection - Maintenance database: devices_api_dev
* Connection - Username: postgres
* Connection - Password: postgres
* Save
* Now you can access the database on node localhost in Servers

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running tests
* mix test

## Show coverage
* mix coveralls