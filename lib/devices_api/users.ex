defmodule DevicesApi.Users do
  @moduledoc """
  Delegate functions to handle users context
  """
  alias DevicesApi.Users.Commands.Create

  defdelegate create_user(params), to: Create, as: :execute
end
