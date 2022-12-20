defmodule DevicesApi.Signin.Steps.TokenCreate do
  @moduledoc """
  Gets a user by filter
  """
  alias DevicesApi.Token.JwtAuthToken
  alias DevicesApi.Users.Schemas.User

  @spec execute(User.t()) :: {:ok, String.t()}
  @doc "Creates a token"
  def execute(%User{} = user) do
    JwtAuthToken.create(user.id, user.email)
  end
end
