defmodule DevicesAPIWeb.ErrorView do
  @moduledoc """
  Errors views
  """
  use DevicesAPIWeb, :view

  def render("default_error.json", %{message: message}) do
    %{error: message}
  end

  def render("field_errors.json", %{message: messages}) when is_list(messages) do
    %{error: render_many(messages, __MODULE__, "field_error.json")}
  end

  def render("field_error.json", %{error: {field, {error_message, _}}}) do
    %{field: field, error_message: error_message}
  end
end
