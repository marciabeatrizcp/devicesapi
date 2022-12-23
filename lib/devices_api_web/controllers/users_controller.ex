defmodule DevicesApiWeb.UsersController do
  @moduledoc """
  Endpoints to handle Users
  """
  alias DevicesApi.Changesets
  alias DevicesApi.Signin
  alias DevicesApi.Users
  alias DevicesApi.Users.Inputs.SigninRequestInput
  alias DevicesApi.Users.Inputs.SignupRequestInput

  use DevicesAPIWeb, :controller

  action_fallback(DevicesApiWeb.FallbackControler)

  @doc "Executes a user sign up"
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

  @doc "Executes a user sign in"
  @spec sign_in(conn :: Plug.Conn.t(), map) ::
          {:error, {:invalid_params, Ecto.Changeset.t()}}
          | {:error, {:forbidden, String.t()}}
          | Plug.Conn.t()
  def sign_in(conn, params) do
    with {:ok, input} <- Changesets.cast_and_apply(SigninRequestInput, params),
         {:ok, token} <- Signin.execute(input) do
      conn
      |> put_status(:ok)
      |> render("signin.json", token: token)
    else
      {:error, {:invalid_params, changeset}} -> {:error, {:invalid_params, changeset}}
      {:error, {:forbidden, message}} -> {:error, {:forbidden, message}}
    end
  end
end
