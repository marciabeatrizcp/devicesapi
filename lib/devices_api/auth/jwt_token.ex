defmodule DevicesApi.Auth.JwtToken do
  @moduledoc """
  Functions to handle token context
  """

  @doc "Creates a token"
  @spec create(id :: String.t(), email :: String.t()) ::
          :error | {:ok, String.t()}
  def create(id, email, expired_in \\ nil) do
    expired_in = token_expiration(expired_in)

    # JSON Web Keys
    jwk = build_jwk()

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

    token = JOSE.JWT.sign(jwk, jws, jwt) |> JOSE.JWS.compact() |> elem(1)

    {:ok, token}
  end

  @doc "Verifies signature"
  @spec verify_signature(any) ::
          {:error, String.t()} | {:ok, list | {:jose_jwt, map} | JOSE.JWT.t()}
  def verify_signature(token) do
    case JOSE.JWT.verify(build_jwk(), token) do
      {true, claims, _} -> {:ok, claims}
      _ -> {:error, :invalid_token}
    end
  end

  @doc "Verifies secret"
  @spec verify_claims(JOSE.JWT.t()) :: {:error, String.t()} | {:ok, JOSE.JWT.t()}
  def verify_claims(%JOSE.JWT{fields: fields} = claims) do
    %{"exp" => exp} = fields
    {:ok, expiration_as_datetime} = DateTime.from_unix(exp)

    case DateTime.compare(expiration_as_datetime, DateTime.utc_now()) do
      :gt -> {:ok, claims}
      _ -> {:error, :expired_token}
    end
  end

  @doc "Encodes secret"
  @spec encode_secret :: binary
  def encode_secret do
    :devices_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:jwt_secret_hs256_signature)
    |> :jose_base64url.encode()
  end

  defp token_expiration(value) do
    value || Application.get_env(:devices_api, __MODULE__)[:jwt_expiration_time_minutes]
  end

  defp token_issuer do
    :devices_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:jwt_issuer)
  end

  defp build_jwk do
    %{
      "kty" => "oct",
      "k" => encode_secret()
    }
  end
end
