defmodule DevicesApiWeb.FallbackControler do
  @moduledoc """
  Translates controller action results into valid admin `Plug.Conn` responses.
  """

  use DevicesAPIWeb, :controller

  @validation_errors [
    :invalid_id
  ]

  @unauthenticated_errors [
    :unauthenticated
  ]

  @not_found_errors [
    :not_found,
    :user_not_found
  ]

  @doc "Response the changeset error or bad request error"
  @spec call(conn :: Plug.Conn.t(), {:error, Ecto.Changeset.t()}) :: Plug.Conn.t()
  def call(conn, {:error, %Ecto.Changeset{errors: errors}}) do
    render_error(conn, :unprocessable_entity, errors, "field_errors.json")
  end

  @spec call(conn :: Plug.Conn.t(), {:error, {atom(), Ecto.Changeset.t()}}) :: Plug.Conn.t()
  def call(conn, {:error, {:invalid_params, %Ecto.Changeset{errors: errors}}}) do
    render_error(conn, :bad_request, errors, "field_errors.json")
  end

  @spec call(conn :: Plug.Conn.t(), {:error, atom()}) :: Plug.Conn.t()
  def call(conn, {:error, :user_not_found}) do
    render_error(conn, :not_found, "User not found")
  end

  @spec call(conn :: Plug.Conn.t(), {:error, atom()}) :: Plug.Conn.t()
  def call(conn, {:error, :not_found}) do
    render_error(conn, :not_found, "Not found")
  end

  def call(conn, {:error, error}) when error in @unauthenticated_errors do
    render_error(conn, :unauthorized, "Unauthorized")
  end

  def call(conn, {:error, error}) when error in @validation_errors do
    render_error(conn, :bad_request, "Invalid params")
  end

  @spec call(conn :: Plug.Conn.t(), {:error, String.t()}) :: Plug.Conn.t()
  def call(conn, {:error, message}) do
    render_error(conn, :bad_request, message)
  end

  defp render_error(conn, status, message, error \\ "default_error.json") do
    conn
    |> put_status(status)
    |> put_view(DevicesAPIWeb.ErrorView)
    |> render(error, message: message)
  end
end
