defmodule DevicesApi.Signin.Commands.IdentifyUser do
  @moduledoc """
  Retrieves a user by email
  """

  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @doc "Gets a User from database by email"
  @spec execute(email :: String.t()) ::
          {:error, :user_not_found} | {:ok, User.t()}
  def execute(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :user_not_found}
    end
  end
end
