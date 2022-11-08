defmodule DevicesApiWeb.UsersController do
  @moduledoc """
  Endpoints to handle Users
  """

  use DevicesAPIWeb, :controller

  action_fallback(DevicesApiWeb.FallbackControler)

  @doc "Signs a user up with password"
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, user} <- DevicesAPI.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end