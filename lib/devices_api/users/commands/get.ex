defmodule DevicesApi.Users.Commands.Get do
  @moduledoc """
  Gets a user for a given id
  """
  alias Ecto.UUID
  alias DevicesApi.Users.Schemas.User
  alias DevicesAPI.Repo

  @spec execute(id :: String.t()) :: {:ok, Ecto.UUID.t()} | {:error, String.t()}
  def execute(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end
end
