defmodule DevicesApi.Users.Commands.Create do
  @moduledoc """
  Creates a new user
  """
  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @type user_params :: %{
          name: String.t(),
          password: String.t(),
          email: String.t()
        }

  @spec execute(user_params()) :: {:error, Ecto.Changeset.t()} | {:ok, Ecto.Schema.t()}
  def execute(params) when is_map(params) do
    with %Ecto.Changeset{valid?: true} = changeset <- User.changeset(params),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      {:error, _} = err -> err
    end
  end
end
