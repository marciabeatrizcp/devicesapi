defmodule DevicesApi.Users.Commands.Get do
  @moduledoc """
  Gets a user by id
  """
  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @spec execute(id :: String.t()) ::
          {:ok, struct()} | {:error, :invalid_params | :not_found, String.t()}
  def execute(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end
end
