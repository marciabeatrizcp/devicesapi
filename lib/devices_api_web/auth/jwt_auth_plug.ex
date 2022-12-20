defmodule DevicesApiWeb.Auth.JwtAuthPlug do
  import Plug.Conn

  alias DevicesApi.Token.JwtAuthToken

  def init(opts) do
    opts
  end

  defp get_jwk() do
    JwtAuthToken.build_jwk()
  end

  defp authenticate({conn, "Bearer " <> jwt}) do
    case JwtAuthToken.token_verify(get_jwk(), jwt) do
      {:ok, claims} -> assign(conn, :user, claims)
      {:error, err} -> send_401(conn, %{error: err})
    end
  end

  defp authenticate(_) do
    :error
  end

  defp send_401(
         conn,
         data
       ) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(data))
    |> halt
  end

  defp get_auth_header(conn) do
    case get_req_header(conn, "authorization") do
      [token] -> {conn, token}
      _ -> {conn}
    end
  end

  def call(%Plug.Conn{request_path: _path} = conn, _opts) do
    conn
    |> get_auth_header
    |> authenticate
  end
end
