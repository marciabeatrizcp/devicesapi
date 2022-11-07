defmodule DevicesApiWeb.UsersController do
  @moduledoc """
  Endpoints to handle Users
  """

  use DevicesAPIWeb, :controller

  action_fallback(DevicesApiWeb.FallbackControler)

  def create(conn, params) do
    with {:ok, user} <- DevicesAPI.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
