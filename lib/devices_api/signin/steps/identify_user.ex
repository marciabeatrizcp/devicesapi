defmodule DevicesApi.Signin.Steps.IdentifyUser do
  @moduledoc """
  Gets a user by email
  """
  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User

  @doc "Checks email and password input."
  @spec execute(email :: String.t()) ::
          {:error, :not_found} | {:ok, User.t()}
  def execute(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end
end
