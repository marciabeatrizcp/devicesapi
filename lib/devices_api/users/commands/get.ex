defmodule DevicesApi.Users.Commands.Get do
  @moduledoc """
  Gets an user by id
  """
  alias Ecto.UUID
  alias DevicesApi.Users.Schemas.User
  alias DevicesAPI.Repo

  @doc """
  Retrieves an user from database.

  ## Examples

    iex> {:ok, %User{}} = execute(uuid)

    iex> {:error, :not_found, "User not found!"} = Users.Get.execute(not_found_user_id)

    iex> {:error, "Invalid ID format!"} = execute(invalid_user_id)

  """

  @spec execute(id :: String.t()) :: {:ok, Ecto.UUID.t()} | {:error, String.t()}
  def execute(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, :not_found, "User not found!"}
      user -> {:ok, user}
    end
  end
end
