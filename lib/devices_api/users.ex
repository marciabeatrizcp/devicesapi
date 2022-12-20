defmodule DevicesApi.Users do
  @moduledoc """
  Delegate functions to handle users context
  """
  alias DevicesApi.Users.Commands.{Create, Get}
  alias DevicesApi.Users.Inputs.SignupRequestInput
  alias DevicesApi.Users.Schemas.User

  @doc """
  Inserts a user into the database.

  ## Examples


    iex> user_params = %{name: "beatriz", password: "123457", email: "beatriz@teste.com.br"}

    iex> {:ok, %User{}} = create(user_params)

    iex> {:error, %Ecto.Changeset{}} = execute(%{})

  """
  @spec create(SignupRequestInput.t()) ::
          {:error, Ecto.Changeset.t()} | {:ok, User.t()}
  defdelegate create(params), to: Create, as: :execute

  @doc """
  Gets a `User` by id

  ## Examples

    iex> {:ok, %User{}} = execute(uuid)

    iex> {:error, :not_found, "User not found!"} = get(not_found_user_id)

    iex> {:error, "Invalid ID format!"} = execute(invalid_user_id)

  """
  @spec get(binary) ::
          {:ok, User.t()} | {:error, :not_found, String.t()} | {:error, String.t()}
  defdelegate get(params), to: Get, as: :execute
end
