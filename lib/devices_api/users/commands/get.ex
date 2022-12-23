defmodule DevicesApi.Users.Commands.Get do
  @moduledoc """
  Retrieves a single User by its id
  """
  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @doc "Gets a user by id"
  @spec execute(id :: String.t()) ::
          {:ok, User.t()} | {:error, :invalid_params | :not_found, String.t()}
  def execute(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end
end
