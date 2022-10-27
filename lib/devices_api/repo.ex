defmodule DevicesAPI.Repo do
  @moduledoc """
  This module is the foundation we need to work with databases in a Phoenix application
  """
  use Ecto.Repo,
    otp_app: :devices_api,
    adapter: Ecto.Adapters.Postgres
end
