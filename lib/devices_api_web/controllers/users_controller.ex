defmodule DevicesApiWeb.UsersController do
  @moduledoc """
  Endpoints to handle Users
  """
  alias DevicesApi.ChangesetValidation
  alias DevicesApi.Users
  alias DevicesApi.Users.Inputs.SignupRequestInput

  use DevicesAPIWeb, :controller

  action_fallback DevicesApiWeb.FallbackControler

  @doc "Signs a user up with password"
  @spec create(conn :: Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_aply_changes(SignupRequestInput, params),
         {:ok, user} <- Users.create(data) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  @doc "Gets a user by id"
  @spec show(conn :: Plug.Conn.t(), map) ::
          {:error, :not_found, String.t()} | {:error, :bad_request, String.t()} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
