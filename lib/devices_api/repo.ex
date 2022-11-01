defmodule DevicesAPI.Repo do
  @moduledoc """
  Repo configuration
  """
  use Ecto.Repo,
    otp_app: :devices_api,
    adapter: Ecto.Adapters.Postgres
end
