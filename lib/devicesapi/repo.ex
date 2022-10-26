defmodule Devicesapi.Repo do
  use Ecto.Repo,
    otp_app: :devicesapi,
    adapter: Ecto.Adapters.Postgres
end
