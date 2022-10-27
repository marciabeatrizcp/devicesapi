# Devices API

## Requirements:
  * run this command `asdf install` 
  * docker >= 20.10.12
  * docker-compose
  * Elixir 1.13.3-otp-24
  * Erlang 24.0.3
  

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
* **URL:** `http://localhost:5050`
* **Username:** admin@admin.com 
* **Password:** admin (as a default)

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
