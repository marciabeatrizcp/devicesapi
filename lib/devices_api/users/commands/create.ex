defmodule DevicesApi.Users.Commands.Create do
  @moduledoc """
  Creates an new user
  """
  alias DevicesApi.Users.Schemas.User
  alias DevicesAPI.Repo

  @type user_params :: %{
          name: String.t(),
          passord: String.t(),
          email: String.t()
        }

  @doc """
  Inserts an user into the database.

  ## Examples

    iex> alias DevicesApi.Users

    iex> alias DevicesApi.Users.Schemas.User

    iex> user_params = %{name: "beatriz", password: "123457", email: "beatriz@teste.com.br"}

    iex> {:ok, %User{}} = Users.Create.execute(user_params)

    iex> {:error, %Ecto.Changeset{}} = Users.Create.execute(%{})

  """
  @spec execute(user_params()) :: {:error, Ecto.Changeset.t()} | {:ok, Ecto.Schema.t()}
  def execute(params) when is_map(params) do
    with %Ecto.Changeset{} = changeset <- User.changeset(params),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end
end
