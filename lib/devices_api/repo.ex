defmodule DevicesAPI.Repo do
  use Ecto.Repo,
    otp_app: :devices_api,
    adapter: Ecto.Adapters.Postgres
end
