defmodule DevicesApiWeb.UsersView do
  @moduledoc """
  Users views
  """

  @doc "Renders a user"
  @spec render(String.t(), map()) :: map()
  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  @doc "Renders a token"
  def render("signin.json", %{token: token}) do
    %{
      token: token
    }
  end
end
