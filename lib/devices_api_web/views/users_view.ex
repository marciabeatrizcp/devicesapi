defmodule DevicesApiWeb.UsersView do
  @moduledoc """
  Users views
  """
  alias Postgrex.Extensions.JSON
  @doc "Renders an user"
  @spec render(String.t(), map()) :: JSON.t()
  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
