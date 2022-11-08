defmodule DevicesApi.Users.Create do
  @moduledoc """
  Domain functions for the User context
  """
  alias DevicesApi.Users.Schemas.User
  alias DevicesAPI.Repo

  @type user_params :: %{
          name: String.t(),
          passord: String.t(),
          email: String.t()
        }

  @doc """
  Inserts a user into the database.

  ## Examples

  iex> alias DevicesApi.Users
  ...> alias DevicesApi.Users.Schemas.User
  ...> user_params = %{
  ...>  name: "Beatriz",
  ...>  passord: "95270000",
  ...>  email: "beatriz@gmail.com"
  ...> }
  ...>
  ...> {:ok, %User{}} = Users.Create.execute user_params
  ...>
  iex> {:error, %Ecto.Changeset{}} = Users.Create.execute %{}
  """
  @spec execute(user_params()) :: {:error, Ecto.Changeset.t()} | {:ok, Ecto.Schema.t()}
  def execute(params) do
    with %Ecto.Changeset{} = changeset <- User.changeset(params),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end
end
