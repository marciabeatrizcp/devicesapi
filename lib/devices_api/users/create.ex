defmodule DevicesApi.Users.Create do
  @moduledoc """
  Domain functions for the User context
  """

  alias DevicesApi.Users.Schemas.Users
  alias DevicesAPI.Repo

  @doc "Create a new user"
  def execute(params) do
    with %Ecto.Changeset{} = changeset <- Users.changeset(params),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end
end
