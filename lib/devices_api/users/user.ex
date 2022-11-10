defmodule DevicesApi.Users.User do
  @moduledoc """
  Delegate functions to handle users
  """
  alias DevicesApi.Users.Commands.Create

  defdelegate create_user(params), to: Create, as: :execute
end