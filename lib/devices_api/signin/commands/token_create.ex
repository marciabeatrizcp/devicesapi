defmodule DevicesApi.Signin.Commands.TokenCreate do
  @moduledoc """
  Creates a token
  """
  alias DevicesApi.Auth.JwtToken
  alias DevicesApi.Users.Schemas.User

  @spec execute(User.t()) :: {:ok, String.t()}
  @doc "Creates a token"
  def execute(%User{} = user) do
    JwtToken.create(user.id, user.email)
  end
end
