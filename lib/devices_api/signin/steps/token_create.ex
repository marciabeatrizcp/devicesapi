defmodule DevicesApi.Signin.Steps.TokenCreate do
  @moduledoc """
  Gets a user by filter
  """

  alias DevicesApi.Users.Schemas.User

  @doc "Creates a token"
  @spec execute(user :: User.t()) ::
          :error | {:ok, String.t()}
  def execute(%User{} = user) do
    payload = %{"user" => user.id}
    header = %{"alg" => "HS256", typ: "JWT"}
    jwk_hs256 = JOSE.JWK.generate_key({:oct, 16})

    signed_hs256 =
      jwk_hs256
      |> JOSE.JWT.sign(header, payload)
      |> JOSE.JWS.compact()
      |> elem(1)

    {:ok, signed_hs256}
  end
end
