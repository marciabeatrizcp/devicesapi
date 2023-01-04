defmodule DevicesApiWeb.JwtAuthPlug do
  @moduledoc """
  Enables token verification
  """

  import Plug.Conn

  alias DevicesApi.Auth.JwtToken

  @doc "Initializes plug"
  @spec init(opts :: Keyword.t()) :: list()
  def init(opts) do
    opts
  end

  @doc "Verifies a token"
  @spec call(conn :: Plug.Conn.t(), opts :: list()) :: {:unauthorized, String.t()} | Plug.Conn.t()
  def call(conn, _opts) do
    with {:ok, token} <- extract_token(conn),
         {:ok, claims} <- JwtToken.verify_signature(token),
         {:ok, claims} <- JwtToken.verify_claims(claims) do
      conn
      |> assign(:current_user, claims)
    else
      {:error, _ = message} -> unauthorize(conn, message)
    end
  end

  defp extract_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token | _] -> {:ok, token}
      _ -> {:error, :token_not_found}
    end
  end

  defp unauthorize(conn, message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:unauthorized, Jason.encode!(%{error: message}))
    |> halt()
  end
end
