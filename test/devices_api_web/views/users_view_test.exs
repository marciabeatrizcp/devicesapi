defmodule DevicesApiWeb.UsersViewTest do
  use DevicesAPIWeb.ConnCase, async: true

  import Phoenix.View

  alias DevicesApi.Users.Schemas.User

  test "renders create.json" do
    user = %User{
      id: "b951aad2-8f6d-4d1e-867a-042fd1ff19cc",
      name: "Beatriz",
      email: "beatriz@gmail7.com.br",
      inserted_at: ~N[2022-11-09 14:50:10],
      updated_at: ~N[2022-11-09 14:50:10]
    }

    assert render(DevicesApiWeb.UsersView, "create.json", %{user: user}) == %{
             email: "Beatriz",
             id: "b951aad2-8f6d-4d1e-867a-042fd1ff19cc",
             inserted_at: ~N[2022-11-09 14:50:10],
             name: "Beatriz",
             updated_at: ~N[2022-11-09 14:50:10]
           }
  end
end
