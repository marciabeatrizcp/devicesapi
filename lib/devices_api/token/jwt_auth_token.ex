defmodule DevicesApi.Token.JwtAuthToken do
  @moduledoc """
  Functions to handle token context
  """

  @doc "Creates a token"
  @spec create(id :: String.t(), email :: String.t()) ::
          :error | {:ok, String.t()}
  def create(id, email) do
    expired_in = token_expiration()

    # JSON Web Keys
    jwk = %{
      "kty" => "oct",
      "k" => encode_secret()
    }

    # JSON Web Signature (JWS)*
    jws = %{
      "alg" => "HS256"
    }

    # JSON Web Token (JWT)*
    jwt = %{
      "iss" => token_issuer(),
      "sub" => id,
      "exp" => DateTime.utc_now() |> DateTime.add(expired_in * 60, :second) |> DateTime.to_unix(),
      "iat" => DateTime.utc_now() |> DateTime.to_unix(),
      "email" => email
    }

    {_, token} = JOSE.JWT.sign(jwk, jws, jwt) |> JOSE.JWS.compact()

    {:ok, token}
  end

  @spec token_verify(jwk :: map(), token :: String.t()) ::
          {:error, String.t()} | {:ok, {:jose_jwt, map} | JOSE.JWT.t()}
  def token_verify(jwk, token) do
    case JOSE.JWT.verify(jwk, token) do
      {true, claims, _} -> {:ok, claims}
      _ -> {:error, "Token signature verification failed!"}
    end
  end

  defp encode_secret do
    :devices_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:jwt_secret_hs256_signature)
    |> :jose_base64url.encode()
  end

  defp token_expiration do
    :devices_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:jwt_expiration_time_minutes)
  end

  defp token_issuer do
    :devices_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:jwt_issuer)
  end
end
