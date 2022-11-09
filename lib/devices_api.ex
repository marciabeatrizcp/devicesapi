defmodule DevicesAPI do
  @moduledoc """
  Delegate functions to handle users and devices
  """
  alias DevicesApi.Users.User

  defdelegate create_user(params), to: User, as: :create
end
