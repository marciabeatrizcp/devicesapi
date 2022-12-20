import Config

config :devices_api,
  namespace: DevicesAPI,
  ecto_repos: [DevicesAPI.Repo],
  generators: [binary_id: true]

# Configures the token
config :devices_api, DevicesApiWeb.Auth.JwtToken,
  jwt_issuer: "deviceapi.com.br",
  jwt_expiration_time_minutes: 30,
  jwt_secret_hs256_signature: "oh my god"

# Configures the endpoint
config :devices_api, DevicesAPIWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DevicesAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  live_view: [signing_salt: "E1Ws5z0s"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
