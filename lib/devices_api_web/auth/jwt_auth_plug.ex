defmodule DevicesApiWeb.Auth.JwtAuthPlug do
  @moduledoc """
  Enables token verification
  """

  import Plug.Conn

  alias DevicesApiWeb.Auth.JwtToken

  def init(opts) do
    opts
  end

  def call(%Plug.Conn{request_path: _path} = conn, _opts) do
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
      ["Bearer " <> token] -> {:ok, token}
      _ -> {:error, "No authorization token found!"}
    end
  end

  defp unauthorize(conn, message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:unauthorized, Jason.encode!(%{error: message}))
    |> halt()
  end
end
