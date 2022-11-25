defmodule DevicesApi.Users.Commands.Get do
  @moduledoc """
  Gets a user by id
  """
  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @spec execute(id :: String.t()) :: {:ok, Ecto.UUID.t()} | {:error, String.t()}

  def execute(id) do
    with {:id, {:ok, _}} <- {:id, Ecto.UUID.cast(id)},
         {:ok, %User{} = user} <-
           {:ok, Repo.get(User, id)} do
      {:ok, user}
    else
      {:id, :error} -> {:error, :invalid_params, "Invalid ID format!"}
      {:ok, nil} -> {:error, :not_found, "User not found!"}
    end
  end
end
