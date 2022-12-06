defmodule DevicesApiWeb.UsersController do
  @moduledoc """
  Endpoints to handle Users
  """
  alias DevicesApi.Changesets
  alias DevicesApi.Users
  alias DevicesApi.Users.Inputs.SignupRequestInput

  use DevicesAPIWeb, :controller

  action_fallback DevicesApiWeb.FallbackControler

  @doc "Signs a user up with password"
  @spec create(conn :: Plug.Conn.t(), map) ::
          {:error, :invalid_params, Ecto.Changeset.t()} | Plug.Conn.t()
  def create(conn, params) do
    with {:ok, input} <- Changesets.cast_and_apply(SignupRequestInput, params),
         {:ok, user} <- Users.create(input) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  @doc "Gets a user by id"
  @spec show(conn :: Plug.Conn.t(), map) ::
          {:error, :invalid_params | :not_found, String.t()} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, uuid} <- Ecto.UUID.cast(id),
         {:ok, user} <- Users.get(uuid) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    else
      :error -> {:error, "Invalid ID format!"}
      {:error, :not_found} -> {:error, {:not_found, "User not found!"}}
    end
  end
end
