defmodule DevicesAPI do
  @moduledoc """
  Delegate functions to handle users and devices
  """
  alias DevicesApi.Users

  defdelegate create_user(params), to: Users.Create, as: :execute
end
