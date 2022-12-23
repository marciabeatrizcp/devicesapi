defmodule DevicesApi.Signin.Steps.TokenCreate do
  @moduledoc """
  Creates a token
  """
  alias DevicesApi.Users.Schemas.User
  alias DevicesApiWeb.Auth.JwtToken

  @spec execute(User.t()) :: {:ok, String.t()}
  @doc "Creates a token"
  def execute(%User{} = user) do
    JwtToken.create(user.id, user.email)
  end
end
