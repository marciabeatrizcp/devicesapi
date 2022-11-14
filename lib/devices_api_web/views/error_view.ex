defmodule DevicesAPIWeb.ErrorView do
  @moduledoc """
  Errors views
  """
  use DevicesAPIWeb, :view

  @doc "Renders a default error"
  def render("default_error.json", %{message: message}) do
    %{error: message}
  end

  @doc "Renders a changeset error"
  @spec render(String.t(), map()) :: map()
  def render("field_error.json", %{error: {field, {error_message, _}}}) do
    %{field: field, error_message: error_message}
  end

  @doc "Renders a list of changeset errors"
  def render("field_errors.json", %{message: messages}) when is_list(messages) do
    %{error: render_many(messages, __MODULE__, "field_error.json")}
  end
end
