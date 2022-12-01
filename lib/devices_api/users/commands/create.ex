defmodule DevicesApi.Users.Commands.Create do
  @moduledoc """
  Creates a new user
  """

  alias DevicesAPI.Repo
  alias DevicesApi.Users.Inputs.SignupRequestInput
  alias DevicesApi.Users.Schemas.User

  @spec execute(input :: SignupRequestInput.t()) ::
          {:error, Ecto.Changeset.t()} | {:ok, User.t()}
  def execute(%SignupRequestInput{} = input) do
    with %Ecto.Changeset{valid?: true} = changeset <-
           User.changeset(_build_create(input)),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      {:error, _} = err -> err
    end
  end

  defp _build_create(input) do
    %{
      name: input.name,
      password: input.password,
      email: input.email
    }
  end
end
