defmodule DevicesApiWeb.UsersView do
  @moduledoc """
  Users views
  """

  def render("create.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.name,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
