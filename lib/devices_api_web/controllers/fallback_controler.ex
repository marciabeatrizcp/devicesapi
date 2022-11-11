defmodule DevicesApiWeb.FallbackControler do
  @moduledoc """
  Translates controller action results into valid admin `Plug.Conn` responses.
  """

  use DevicesAPIWeb, :controller

  @doc "Response the changeset error or bad request error"
  @spec call(Plug.Conn.t(), {:error, Ecto.Changeset.t()}) :: Plug.Conn.t()
  def call(conn, {:error, %Ecto.Changeset{errors: errors}}) do
    render_error(conn, :unprocessable_entity, errors, "field_errors.json")
  end

  @spec call(Plug.Conn.t(), {:error, String.t()}) :: Plug.Conn.t()
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
