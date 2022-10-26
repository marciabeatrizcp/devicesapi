# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :devicesapi,
  ecto_repos: [Devicesapi.Repo]

# Configures the endpoint
config :devicesapi, DevicesapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "abHkanekiElmHuym9h1ERUDuTWcLZzc2QZDH0yK9UJBTzrL01HhBF5Bio+oL9ZG4",
  render_errors: [view: DevicesapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Devicesapi.PubSub,
  live_view: [signing_salt: "VkHN0sfZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
