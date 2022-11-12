defmodule DevicesApi.Users do
  @moduledoc """
  Delegate functions to handle users context
  """
  alias DevicesApi.Users.Commands.Create
  alias DevicesApi.Users.Commands.Get

  defdelegate create_user(params), to: Create, as: :execute
  defdelegate get_user(params), to: Get, as: :execute
end
