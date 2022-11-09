defmodule DevicesApiWeb.FallbackControler do
  use DevicesAPIWeb, :controller

  @moduledoc """
  Fallback to handle errors
  """

  def call(conn, {:error, %Ecto.Changeset{errors: errors}}) do
    render_error(conn, :unprocessable_entity, errors, "field_errors.json")
  end

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
