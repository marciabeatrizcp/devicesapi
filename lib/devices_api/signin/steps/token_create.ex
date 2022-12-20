defmodule DevicesApi.Signin.Steps.TokenCreate do
  @moduledoc """
  Gets a user by filter
  """
  alias DevicesApi.Token.JwtAuthToken
  alias DevicesApi.Users.Schemas.User

  @doc "Creates a token"
  # @spec create(user :: User.t()) ::
  # :error | {:ok, String.t()}
  def execute(%User{} = user) do
    JwtAuthToken.create(user.id, user.email)
  end
end
